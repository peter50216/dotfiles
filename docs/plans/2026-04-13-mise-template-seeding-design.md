# Mise Template Seeding Design

## Goal

Keep `mise` usable as a normal interactive tool on each machine while still
providing repo-managed defaults during bootstrap.

## Problem

The current repo uses Home Manager `programs.mise.globalConfig` in
`packages.nix` and `local.nix` to generate the global mise configuration.
That makes `~/.config/mise/config.toml` generated state instead of a
user-owned config file.

This creates three practical problems:

1. `mise use --global ...` and manual edits fight with Home Manager.
2. Small `mise` config changes require a Nix edit plus `home-manager switch`.
3. Updating `mise` defaults is coupled to the broader pinned Nix/Home Manager
   configuration.

## Chosen Approach

Adopt a seed-once template model for global `mise` config.

### Ownership

- Home Manager may continue to install the `mise` binary.
- The repo owns only a starter template for `mise` global config.
- Each machine owns the live `~/.config/mise/config.toml` after bootstrap.

### Behavior

- Move the current repo-wide `mise` defaults out of Home Manager
  `programs.mise.globalConfig`.
- Store those defaults in a plain repo template file.
- During one-time setup, copy the template to
  `~/.config/mise/config.toml` only when the file does not already exist.
- Never overwrite an existing live `mise` config.

## Why This Approach

This keeps the useful part of the current setup:

- repo-managed defaults for new machines
- declarative installation of packages and custom derivations
- low-friction bootstrap

while restoring the behavior expected from `mise` itself:

- `mise use --global ...` updates a user-owned file
- local machine additions do not require repo changes
- day-to-day config edits do not require a Home Manager switch

## Alternatives Considered

### Keep Home Manager owning `mise` config

Rejected because it preserves the exact workflow friction that triggered this
 change.

### Symlink the repo file directly into `~/.config/mise/config.toml`

Rejected because `mise use --global ...` would still mutate the repo-managed
file.

## Consequences

- Fresh installs get the repo baseline automatically.
- Existing machines keep their current `~/.config/mise/config.toml`.
- Future template edits affect fresh installs only unless an explicit refresh
  mechanism is added later.
- Drift between machines is intentional for `mise` global state.
