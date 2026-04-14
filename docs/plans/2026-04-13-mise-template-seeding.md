# Mise Template Seeding Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace Home Manager-owned global `mise` config with a seed-once settings template so new machines get shared `mise` settings while each machine can later add global `mise` tools independently.

**Architecture:** Keep `mise` installation declarative, but move shared `mise` settings into a plain template file stored in the repo. Extend the existing one-time setup flow to copy that template into `~/.config/mise/config.toml` only when the live file does not already exist, and add a one-time migration that converts the old Home Manager-managed `mise` symlink into a normal user-owned file on existing systems.

**Tech Stack:** Nix, Home Manager, shell activation script, mise TOML config

---

### Task 1: Add the repo-owned `mise` settings template

**Files:**
- Create: `template/mise-config.toml`
- Reference: `packages.nix`
- Reference: `local.nix`

**Step 1: Write the failing test**

Run: `test -f template/mise-config.toml`
Expected: exit status `1` because the template file does not exist yet.

**Step 2: Create the template with the shared settings defaults**

Copy the shared settings values into `template/mise-config.toml`:

```toml
[settings]
experimental = true
idiomatic_version_file_enable_tools = ["python", "ruby"]

[settings.npm]
bun = true
```

**Step 3: Run test to verify it passes**

Run: `test -f template/mise-config.toml`
Expected: exit status `0`.

**Step 4: Sanity-check the content**

Run: `sed -n '1,160p' template/mise-config.toml`
Expected: the TOML contains only the shared `mise` settings defaults.

### Task 2: Remove Home Manager ownership of global `mise` config

**Files:**
- Modify: `packages.nix`
- Modify: `local.nix`

**Step 1: Write the failing test**

Run: `rg -n "globalConfig|jujutsu = \\\"0\\.33\\\"" packages.nix local.nix`
Expected: matches in both files, proving Home Manager still owns the global `mise` config.

**Step 2: Write the minimal implementation**

Update `packages.nix` so `programs.mise` only enables the program without
declaring `globalConfig`.

Update `local.nix` to remove the `programs.mise.globalConfig.tools.jujutsu`
override entirely.

**Step 3: Run the test to verify the old ownership is gone**

Run: `rg -n "globalConfig|jujutsu = \\\"0\\.33\\\"" packages.nix local.nix`
Expected: no matches.

**Step 4: Verify Nix syntax still parses**

Run: `nix-instantiate --parse default.nix`
Expected: successful parse output with exit status `0`.

### Task 3: Seed the live `mise` config and migrate existing symlinks

**Files:**
- Modify: `setup.nix`
- Reference: `template/mise-config.toml`

**Step 1: Write the failing test**

Run: `rg -n "mise/config.toml|mise-config.toml|oldGenPath|readlink -f" setup.nix`
Expected: no matches because setup does not currently seed or migrate `mise`.

**Step 2: Write the minimal implementation**

Extend `setup.nix` in two parts:

1. Add a Home Manager activation entry after `linkGeneration` that copies the
   old Home Manager-managed `mise` config into `~/.config/mise/config.toml`
   when the live file is missing and the previous generation contained the old
   generated `mise` config.

2. Extend the existing `runSetup` activation block to seed fresh installs with:

```sh
if [ ! -f "$HOME/.config/mise/config.toml" ]; then
  run mkdir -p "$HOME/.config/mise"
  run cp ~/dotfiles/template/mise-config.toml "$HOME/.config/mise/config.toml"
fi
```

Place this inside the one-time setup path alongside the existing `.gitconfig`
seeding logic.

**Step 3: Run the test to verify the new logic exists**

Run: `rg -n "mise/config.toml|mise-config.toml|oldGenPath|readlink -f" setup.nix`
Expected: matches showing the new seeding and migration logic.

**Step 4: Verify the repo still evaluates**

Run: `nix-instantiate --parse default.nix`
Expected: successful parse output with exit status `0`.

### Task 4: Document the new `mise` ownership model

**Files:**
- Modify: `AGENTS.md`

**Step 1: Write the failing test**

Run: `rg -n "programs\\.mise\\.globalConfig|template/mise-config.toml|seed" AGENTS.md`
Expected: the file documents the old `globalConfig` model and does not mention the new template seeding flow.

**Step 2: Write the minimal implementation**

Update the relevant `AGENTS.md` sections to explain:

- shared `mise` defaults now live in `template/mise-config.toml`
- `setup.nix` seeds `~/.config/mise/config.toml` only when missing
- `setup.nix` also preserves the old Home Manager-managed `mise` symlink on
  existing systems by converting it into a real file once
- machine-local global `mise` additions should be made with `mise use --global`
  or direct edits to `~/.config/mise/config.toml`

**Step 3: Run the test to verify the docs mention the new model**

Run: `rg -n "template/mise-config.toml|seed|mise use --global" AGENTS.md`
Expected: matching lines that describe the new workflow.

### Task 5: Run final verification

**Files:**
- Verify only

**Step 1: Parse the Nix entrypoint**

Run: `nix-instantiate --parse default.nix`
Expected: exit status `0`.

**Step 2: Build the activation package**

Run: `nix-build`
Expected: successful build and a refreshed `result` symlink.

**Step 3: Optional local apply**

Run: `hm-switch`
Expected: the Home Manager activation completes successfully.

**Step 4: Manual behavior check**

Run: `mise cfg`
Expected: `~/.config/mise/config.toml` appears as a normal user-owned global
config, and future `mise use --global ...` commands update that file rather
than repo-managed Nix configuration.
