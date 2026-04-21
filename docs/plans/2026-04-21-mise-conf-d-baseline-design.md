# Mise Conf.d Baseline Design

Date: 2026-04-21

## Goal

Move shared userland CLI tools out of Nix and into a `mise` baseline while keeping Nix responsible for the shell/session core and Nix-native tooling.

## Design

Use a Home Manager-linked file at `~/.config/mise/conf.d/00-dotfiles.toml` for shared dotfiles defaults. `mise` loads `conf.d/*.toml` alphabetically, so a `00-` file provides a stable baseline while each machine can keep user-owned additions and overrides in `~/.config/mise/config.toml`.

Fresh installs should no longer seed `~/.config/mise/config.toml` from a template. That file remains machine-local state. Existing systems that still have the old Home Manager-managed `~/.config/mise/config.toml` symlink should have that obsolete symlink removed so the new `conf.d` baseline can take over. Newer template-seeded user files are not migrated automatically.

## Tool Boundary

Move these shared tools from Nix to the `mise` baseline:

- `bat`
- `btop`
- `broot` via `github:Canop/broot`
- `dua`
- `eza`
- `fd`
- `fzf`
- `git-lfs`
- `jq`
- `make`
- `neovim`
- `ripgrep`
- `shellcheck`
- `usage`
- `zoxide`

Do not move `hyperfine`; it is no longer needed.

Keep these in Nix:

- `zsh`
- `tmux`
- `tmux-mem-cpu-load`
- `mise`
- `home-manager`
- `npins`
- `nil`
- `bubblewrap`
- `htop`
- `xxd`

`broot` uses GitHub release assets instead of Cargo because upstream publishes prebuilt binaries in its release zip. `htop` stays in Nix because the `cargo:htop` crate is a different HTML-to-PDF tool, not the C process viewer. `xxd` stays in Nix because there is no clean `mise` source for the standard Vim `xxd`.

## Custom Scripts

Vendor `rgr` into this repository and expose both `rgr` and `unarchive` through a Home Manager-managed `~/bin/common -> ~/dotfiles/bin` symlink. This removes the custom Nix derivations for those two scripts while preserving the current command names.

## Verification

Use the normal Nix checks:

- `nix-instantiate --parse default.nix`
- `nix-build`

Also validate the linked `mise` baseline by asking `mise` to parse the generated configuration after Home Manager links it.
