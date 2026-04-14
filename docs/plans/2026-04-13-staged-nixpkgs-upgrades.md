# Staged Nixpkgs Upgrades Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add a staged package-upgrade workflow that lets the repo keep one main Nixpkgs snapshot while selectively sourcing chosen packages from a newer Nixpkgs snapshot until the upgrade is finalized.

**Architecture:** Add a second Nixpkgs pin (`nixpkgs-next`) and a JSON file containing staged package attribute names. Import the next package set separately, then overlay staged packages onto the main `pkgs` import so existing modules continue to use `pkgs` unchanged. Add shell helpers to manage the lifecycle and a once-per-day zsh reminder when the staged upgrade is incomplete.

**Tech Stack:** Nix, Home Manager, npins, jq, zsh

---

### Task 0: Upgrade repo `npins` metadata format

**Files:**
- Modify: `npins/default.nix`
- Modify: `npins/sources.json`

**Step 1: Write the failing test**

Run: `npins update nixpkgs`
Expected: failure complaining that the current `sources.json` format version is
too old for the installed `npins` CLI.

**Step 2: Write the minimal implementation**

Run:

```bash
npins upgrade
```

This regenerates `npins/default.nix` and upgrades `npins/sources.json` to the
current format version expected by the CLI.

**Step 3: Run the verification**

Run: `jq '.version' npins/sources.json`
Expected: the lockfile format version is current enough for `npins` commands to
operate.

### Task 1: Add repo state for staged upgrades

**Files:**
- Modify: `npins/sources.json`
- Create: `upgrade/staged-packages.json`

**Step 1: Write the failing test**

Run: `jq -e '.pins["nixpkgs-next"]' npins/sources.json >/dev/null && test -f upgrade/staged-packages.json`
Expected: failure because the extra pin and staged package file do not exist yet.

**Step 2: Add the second pin**

Add a new `nixpkgs-next` pin to `npins/sources.json` that tracks the same
upstream channel family as the existing `nixpkgs` pin but can be updated
independently.

**Step 3: Create the staged package list**

Create `upgrade/staged-packages.json` with:

```json
[]
```

**Step 4: Run the test to verify the repo state exists**

Run: `jq -e '.pins["nixpkgs-next"]' npins/sources.json >/dev/null && jq -e '. == []' upgrade/staged-packages.json >/dev/null`
Expected: exit status `0`.

### Task 2: Teach Nix evaluation to overlay staged packages from `nixpkgs-next`

**Files:**
- Modify: `default.nix`

**Step 1: Write the failing test**

Run: `rg -n 'nixpkgs-next|staged-packages|overlays' default.nix`
Expected: no matches because the current evaluation uses only one package set.

**Step 2: Write the minimal implementation**

Update `default.nix` to:

- import `sources."nixpkgs-next"` as a raw package set
- load `upgrade/staged-packages.json` via `builtins.fromJSON`
- define an overlay that maps each staged package attribute name to the
  corresponding package from `pkgsNextRaw`
- import the main `sources.nixpkgs` with that overlay applied

The result should preserve the existing `pkgs` interface so modules do not need
to be rewritten just to consume staged packages.

**Step 3: Run the test to verify the wiring exists**

Run: `rg -n 'nixpkgs-next|staged-packages|overlays' default.nix`
Expected: matches showing the second pin import and overlay logic.

**Step 4: Verify Nix syntax still parses**

Run: `nix-instantiate --parse default.nix`
Expected: exit status `0`.

### Task 3: Add helper commands for staged upgrade workflow

**Files:**
- Modify: `zsh/functions.zsh`

**Step 1: Write the failing test**

Run: `rg -n 'nix-upgrade-(begin|stage|unstage|status|finish|abort)' zsh/functions.zsh`
Expected: no matches because the helpers do not exist yet.

**Step 2: Write the minimal implementation**

Add shell functions:

- `nix-upgrade-begin`
- `nix-upgrade-stage`
- `nix-upgrade-unstage`
- `nix-upgrade-status`
- `nix-upgrade-finish`
- `nix-upgrade-abort`

Implementation requirements:

- use `npins update nixpkgs-next` to refresh the next snapshot
- use `jq` to read and modify `upgrade/staged-packages.json`
- use `jq` to compare and copy pin objects inside `npins/sources.json`
- keep staged package names sorted and unique
- print actionable status output rather than raw JSON
- make `nix-upgrade-abort` reset `nixpkgs-next` back to `nixpkgs` and clear the
  staged package list so the reminder stops

**Step 3: Run the test to verify the helpers exist**

Run: `rg -n 'nix-upgrade-(begin|stage|unstage|status|finish|abort)' zsh/functions.zsh`
Expected: matching function definitions.

### Task 4: Add once-per-day staged-upgrade reminder

**Files:**
- Modify: `zsh/init.zsh`

**Step 1: Write the failing test**

Run: `rg -n 'nix-upgrade-status|staged-packages|\\.cache/dotfiles' zsh/init.zsh`
Expected: no matches because no reminder exists yet.

**Step 2: Write the minimal implementation**

Add an interactive-shell reminder that:

- checks whether `upgrade/staged-packages.json` is non-empty or whether the
  `nixpkgs` and `nixpkgs-next` pin objects differ
- writes the current date to a cache file under `~/.cache/dotfiles/`
- prints the reminder only if it has not already been shown today
- suppresses output when no upgrade cycle is in progress

The reminder should mention `nix-upgrade-status` as the next action.

**Step 3: Run the test to verify the reminder logic exists**

Run: `rg -n 'nix-upgrade-status|staged-packages|\\.cache/dotfiles' zsh/init.zsh`
Expected: matching lines.

### Task 5: Update package-management documentation

**Files:**
- Modify: `AGENTS.md`

**Step 1: Write the failing test**

Run: `rg -n 'nixpkgs-next|staged upgrade|nix-upgrade-' AGENTS.md`
Expected: no matches because the staged-upgrade workflow is undocumented.

**Step 2: Write the minimal implementation**

Document:

- the existence of `nixpkgs-next`
- the purpose of `upgrade/staged-packages.json`
- the staged upgrade helper commands
- the once-per-day reminder behavior
- the rule that `nixpkgs` remains the default package source until the upgrade
  is finished

**Step 3: Run the test to verify the docs mention the new workflow**

Run: `rg -n 'nixpkgs-next|staged upgrade|nix-upgrade-' AGENTS.md`
Expected: matching lines.

### Task 6: Run final verification

**Files:**
- Verify only

**Step 1: Parse the Nix entrypoint**

Run: `nix-instantiate --parse default.nix`
Expected: exit status `0`.

**Step 2: Build the Home Manager activation**

Run: `nix-build`
Expected: successful build.

**Step 3: Exercise helper status command**

Run: `zsh -lc 'source zsh/functions.zsh; nix-upgrade-status'`
Expected: readable output describing main pin, next pin, and staged packages.

**Step 4: Exercise stage and unstage helpers**

Run: `zsh -lc 'source zsh/functions.zsh; nix-upgrade-stage mise; nix-upgrade-unstage mise'`
Expected: the staged package list updates cleanly and ends back at `[]`.

**Step 5: Optional apply**

Run: `hm-switch`
Expected: activation succeeds and the reminder appears only once per day when an
upgrade cycle is in progress.
