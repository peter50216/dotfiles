# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Home Manager Operations
```bash
# Apply configuration changes (preferred method)
hm-switch

# Alternative: Use home-manager directly (if available in PATH)
home-manager switch
```

### Initial Setup
```bash
# Fresh installation (runs fetch.sh -> install.sh -> home-manager setup)
bash <(curl -s https://raw.githubusercontent.com/peter50216/dotfiles/main/setup/fetch.sh)

# Manual setup after cloning
./setup/install.sh
```

### Nix Operations
```bash
# Update package sources
npins update

# Build configuration without applying
nix-build

# Check nix configuration syntax
nix-instantiate --parse default.nix

# Run package temporarily
npins-run package-name

# Open shell with package available
npins-shell package-name
```

### Version Control
This repository uses **Jujutsu (jj)** for version control instead of git. While git configurations are set up for general system use, repository development uses jj commands:

```bash
# Common jj operations
jj status           # Show working copy status
jj commit           # Commit changes
jj show             # Show current change
jj log              # View commit history
```

## Architecture Overview

### Configuration Structure
- **`home.nix`**: Main home-manager entry point that imports `mkHome.nix` with user-specific parameters
- **`mkHome.nix`**: Core home-manager configuration template that imports all modules
- **`default.nix`**: Nix builder script that creates a `switch` command for applying configurations

### Module Organization
- **`packages.nix`**: Package installations and program configurations (bat, fzf, mise, etc.)
- **`env.nix`**: Environment variables and session paths
- **`file.nix`**: Dotfile symlinking and file management
- **`config/`**: Application-specific configurations (git, tmux)
- **`zsh/`**: Shell configuration split into base, aliases, and prezto setup
- **`local.nix`**: Host-specific package and configuration overrides

### External Configurations
- **`external/nvim/`**: Neovim configuration using lazy.nvim plugin manager with Lua
  - Uses `init.vim` for basic vim settings and `lua/init.lua` for plugin setup
  - 32 Lua plugin files in `lua/plugins/` directory
  - Configured for both standalone nvim and VSCode integration

### Development Tools Setup
- **Language Runtimes**: Node.js 22, Python 3.12, Ruby 3.4, Jujutsu 0.31 via `mise`
- **Version Control**: Git configured for general use, but repository development uses Jujutsu (jj)
- **Shell**: ZSH with Prezto framework and custom functions (`hm-switch`, `npins-shell`, `npins-run`)
- **Editor**: Neovim with extensive Lua plugin ecosystem

### Package Management
- **Custom Packages**: `packages/` contains custom Nix expressions (rgr.nix, tmux-mem-cpu-load.nix, unarchive.nix)
- **Source Management**: `npins` for managing external Nix sources
- **Dependency Pinning**: Uses npins instead of channels for reproducible builds

### Host Customization
- Template system in `template/` for generating per-host configs
- `local.nix` allows per-host package additions without modifying main configuration
- Setup system automatically detects Google vs public environments for git config

## Key Files to Modify

### Adding New Packages
- **System packages**: Add to `packages.nix` or `local.nix` (for host-specific)
- **Custom packages**: Create new .nix file in `packages/` directory

### Configuration Changes
- **Shell customization**: Modify files in `zsh/` directory
- **Application configs**: Add to appropriate module in `config/`
- **Neovim plugins**: Add to `external/nvim/lua/plugins/`

### Environment Setup
- **Environment variables**: Edit `env.nix`
- **Per-host settings**: Modify `local.nix`
- **Dotfile links**: Update `file.nix`

## Testing Configuration Changes

Always test configuration changes before committing:

```bash
# Build to check for syntax errors
nix-build

# Apply changes
hm-switch

# Verify programs work as expected
home-manager generations  # View generation history
```
