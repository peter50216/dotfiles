# Dotfiles Review Notes

Date: 2026-04-14

## Findings

1. `setup/install.sh` rewrites `~/.config/nix/nix.conf` on every rerun.
   - The script uses `[ ! -f ~/.config/nix/ ]`, which checks for a regular file instead of a directory.
   - Because of that, the condition stays true even when `~/.config/nix/` already exists.
   - This makes bootstrap non-idempotent and can overwrite manual Nix settings.
   - Suggested fix: always `mkdir -p ~/.config/nix`, then only create or patch `~/.config/nix/nix.conf` when the `experimental-features = nix-command flakes` line is missing.

2. `setup.nix` uses one global `.setup-done` sentinel for all future one-time setup.
   - That works for the initial bootstrap, but it does not scale well when new one-time setup tasks are added later.
   - New tasks either never run on existing machines or must be split into separate migration hooks.
   - Suggested fix: prefer idempotent checks per task or versioned/per-task markers under a dotfiles-specific state directory.

3. Neovim currently has two local-config mechanisms enabled.
   - `external/nvim/init.vim` enables `exrc`.
   - `external/nvim/lua/plugins.lua` also loads `klen/nvim-config-local` for `.lvimrc`.
   - Keeping both increases mental overhead and makes it unclear which local override path should be used.
   - Suggested fix: standardize on one mechanism, likely `.nvim.lua` via `exrc`, and remove the redundant plugin.

4. Some shell helpers are brittle in non-interactive or bad-input cases.
   - `zsh/init.zsh` runs `stty -ixon` unconditionally, which produces noise when there is no TTY.
   - `npins-shell` and `npins-run` print usage on missing arguments but continue executing instead of returning early.
   - Suggested fix: guard terminal-only setup with a TTY check and make helper usage failures return nonzero immediately.

5. Home Manager emits a git signing compatibility warning during `nix-build`.
   - `programs.git.signing.format` is currently left implicit.
   - The current behavior still works because `home.stateVersion` is older, but a future upgrade could change the default unexpectedly.
   - Suggested fix: make `programs.git.signing.format` explicit to either preserve the current legacy behavior or adopt the newer default intentionally.

## Recommended Order

1. Fix installer idempotency in `setup/install.sh`.
2. Remove or consolidate the duplicate Neovim local-config mechanism.
3. Harden shell helpers and staged-upgrade validation.
4. Revisit `setup.nix` bootstrapping to replace the global `.setup-done` sentinel with per-task checks.
5. Make the git signing format explicit before the next Home Manager compatibility bump.
