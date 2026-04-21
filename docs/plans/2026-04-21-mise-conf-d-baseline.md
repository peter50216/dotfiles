# Mise Conf.d Baseline Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Move shared CLI tools from Nix to a linked `mise conf.d` baseline while preserving a small Nix core.

**Architecture:** Home Manager links `external/mise/00-dotfiles.toml` into `~/.config/mise/conf.d/00-dotfiles.toml`, while custom scripts live under `bin/` and are exposed by a Home Manager-managed `~/bin/common -> ~/dotfiles/bin` symlink. Nix stops installing tools that `mise` now owns, while activation cleanup removes only the obsolete old Home Manager-managed `mise/config.toml` symlink.

**Tech Stack:** Nix Home Manager, `mise`, shell scripts

---

### Task 1: Add linked mise baseline

**Files:**
- Create: `external/mise/00-dotfiles.toml`
- Delete: `template/mise-config.toml`

**Steps:**
1. Create `external/mise/00-dotfiles.toml` with shared settings and `[tools]` entries.
2. Link it through Home Manager to `.config/mise/conf.d/00-dotfiles.toml`.
3. Remove the old template file because fresh installs no longer seed `config.toml`.

### Task 2: Update setup migration

**Files:**
- Modify: `setup.nix`

**Steps:**
1. Keep detecting the old Home Manager-managed `mise/config.toml` store target.
2. Remove the obsolete current symlink if it still points into the old store target.
3. Do not touch regular user-owned `~/.config/mise/config.toml` files.
4. Remove the fresh-install template seeding activation.

### Task 3: Move shared packages

**Files:**
- Modify: `packages.nix`

**Steps:**
1. Remove Nix packages now covered by the `mise` baseline.
2. Keep the Nix core: `nil`, `npins`, `bubblewrap`, `unixtools.xxd`, `htop`, `mise`, `home-manager`, plus shell/session tools from their existing modules.
3. Remove the custom Nix derivation references for `rgr` and `unarchive`.

### Task 4: Vendor custom scripts

**Files:**
- Create: `bin/rgr`
- Create: `bin/unarchive`
- Modify: `file.nix`
- Delete: `packages/rgr.nix`
- Delete: `packages/unarchive.nix`

**Steps:**
1. Vendor the current `rgr` script from the existing Nix-built version.
2. Expose `unarchive` from the repo script.
3. Link `~/bin/common` to `~/dotfiles/bin` so both commands are on PATH through the existing `$HOME/bin` session path.
4. Remove unused custom derivation files once no Nix references remain.

### Task 5: Update docs and verify

**Files:**
- Modify: `AGENTS.md`

**Steps:**
1. Update docs to describe the new `mise conf.d` baseline and custom script links.
2. Run `nix-instantiate --parse default.nix`.
3. Run `nix-build`.
4. Check `jj diff` for unintended changes.
