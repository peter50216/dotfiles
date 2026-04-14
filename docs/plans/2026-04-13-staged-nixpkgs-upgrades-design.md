# Staged Nixpkgs Upgrades Design

## Goal

Support incremental package upgrades across Nixpkgs snapshots without forcing
the whole Home Manager environment to move at once.

The desired workflow is:

1. Keep most packages on a stable "main" Nixpkgs snapshot.
2. Refresh a separate "next" snapshot to the newest revision.
3. Move installed packages one by one onto "next".
4. Roll individual packages back if they cause trouble.
5. Once all desired packages work, promote "next" to become the new "main".

## Problem

The current repo imports a single Nixpkgs pin in `default.nix`:

- `sources.nixpkgs` is the only package-set snapshot.
- All Home Manager modules and `home.packages` entries resolve from that one
  package set.

Because Nixpkgs is a snapshot of the entire package universe rather than a
per-package lockfile, updating `nixpkgs` updates `mise`, `tmux`, `neovim`, and
everything else together.

## Chosen Approach

Introduce a second Nixpkgs pin plus a staged package list, then overlay the
selected packages from "next" onto the main package set.

### Repository State

- `npins` metadata is first upgraded to a current lockfile format so the
  installed `npins` CLI can operate on the repo again.
- `nixpkgs` remains the current main pin.
- `nixpkgs-next` is added as a second pin that tracks the same upstream channel
  independently.
- `upgrade/staged-packages.json` stores the package attribute names currently
  sourced from `nixpkgs-next`.

### Evaluation Model

`default.nix` imports:

- the raw next package set, `pkgsNextRaw`
- the staged package list from `upgrade/staged-packages.json`
- the main package set with an overlay that replaces staged package attributes
  with derivations from `pkgsNextRaw`

That means the rest of the repo can keep using `pkgs.<name>` normally.
When a package name is staged, `pkgs.<name>` resolves to the derivation from
`nixpkgs-next`; otherwise it resolves to the normal derivation from `nixpkgs`.

### Why Overlay Instead Of Per-Module Wiring

This design is intentionally global for staged packages.

If `mise` is staged, then:

- `home.packages` gets `pkgs.mise` from `nixpkgs-next`
- Home Manager modules that internally reference `pkgs.mise` also get the
  staged version

This avoids having to manually thread `pkgsNext` through every module or rely
only on the subset of Home Manager modules that expose a `package` option.

## Helper Workflow

Add shell helpers for the staged-upgrade lifecycle:

- `nix-upgrade-begin`
  - updates `nixpkgs-next` to the newest upstream revision
- `nix-upgrade-stage <pkg>`
  - adds a package attribute name to `upgrade/staged-packages.json`
- `nix-upgrade-unstage <pkg>`
  - removes a package from the staged list
- `nix-upgrade-status`
  - shows the main pin, next pin, and currently staged packages
- `nix-upgrade-finish`
  - copies the `nixpkgs-next` pin state onto `nixpkgs`
  - clears the staged package list
- `nix-upgrade-abort`
  - resets `nixpkgs-next` back to `nixpkgs`
  - clears the staged package list

The helpers are convenience wrappers around `npins` and small JSON edits. They
do not replace Home Manager activation; the user still runs `hm-switch` when
ready to apply the current staged state.

## Reminder Behavior

Show a once-per-day shell reminder when an upgrade cycle is incomplete.

An upgrade is considered in progress if either:

- `upgrade/staged-packages.json` is non-empty, or
- the `nixpkgs` and `nixpkgs-next` pin entries differ

The reminder should:

- run from interactive zsh startup
- print at most once per day
- summarize the main/next divergence and staged package list
- point the user toward `nix-upgrade-status`

The reminder state can be cached under `~/.cache/dotfiles/`.

## Why This Approach

This matches the desired operational workflow:

- most of the system stays on one coherent main snapshot
- individual packages can be promoted one at a time
- rollback is cheap
- completion is explicit and reviewable

It also avoids a full flake migration or per-package source pinning.

## Tradeoffs

### Pros

- Preserves the current Nix/Home Manager structure.
- Supports per-package staged upgrades.
- Works for packages referenced indirectly through Home Manager modules.
- Keeps the default state simple: all packages on `nixpkgs`.

### Cons

- Increases repo complexity by introducing a second package set.
- Staged package names must correspond to real Nixpkgs attribute names.
- Package mixes from different snapshots can still expose runtime or UX issues;
  staged rollout reduces risk, but does not eliminate it.
- Some upgrades may still require simultaneous moves for tightly related
  packages.

## Alternatives Considered

### Update everything together from a single Nixpkgs pin

Rejected because it preserves the current all-or-nothing upgrade pain.

### Import `pkgsNext` only where specific modules expose `package` options

Rejected because coverage would be partial and fragile. Many Home Manager
modules rely on `pkgs.<name>` internally without exposing a dedicated package
override.

### Override individual packages from ad hoc Git commits

Rejected as a default workflow because it is more maintenance-heavy than using
two tracked Nixpkgs snapshots.
