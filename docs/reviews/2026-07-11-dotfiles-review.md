# Dotfiles Review Notes

Date: 2026-07-11

Follow-up to `2026-04-14-dotfiles-review.md`. Of the five April findings, four are
fixed (installer idempotency, per-task setup checks in `setup.nix`, explicit
`signing.format`, and the nvim local-config consolidation is moot with the current
`exrc` setup). One is still open — see finding 7.

## Verified bugs

1. `external/tmux.conf` — the `\` (kill-server) binding is silently lost.
   - Lines 22-23 (`unbind \` / `bind \ confirm-before kill-server`): a trailing
     backslash is a line continuation in tmux config, so both commands merge and
     neither takes effect. Verified on tmux 3.6a with a scratch server: `list-keys`
     shows no kill-server binding while `k` and `u` are present.
   - Fix: quote the key — `unbind '\'` and `bind '\' confirm-before kill-server`.

2. `external/nvim/lua/plugins/comment.lua:4` — `enable = false` is not a lazy.nvim
   key (should be `enabled`), so Comment.nvim still installs and loads. It is fully
   redundant anyway: Neovim 0.10+ has built-in `gc`, and
   `nvim-ts-context-commentstring.lua` already remaps `\` to it.
   - Fix: delete `comment.lua` entirely.

3. `external/nvim/lua/plugins/vim-plugin.lua:17-19` — the `cond` function computes
   `vim.fn.has("macunix")` but never returns it, so it always yields `nil` and the
   plugin never loads, even on macOS.
   - Fix: `return vim.fn.has("macunix") == 1`.

4. `zsh/alias.nix` — `gwdd`/`gidd`/`gsdd`/`gldd` depend on `difft`, which no layer
   installs (not in `packages.nix`, not in the mise baseline, not in this machine's
   local mise config; `command -v difft` fails here). The aliases are shared, so the
   dependency should be too.
   - Fix: add `difftastic` to `external/mise/00-dotfiles.toml`.

5. `external/nvim/lua/plugins/nvim-lspconfig.lua:139` —
   `vim.diagnostic.open_float({ "cursor", focusable = false })` passes the scope as
   a positional array element, which the current API ignores; the CursorHold float
   is line-scoped, not cursor-scoped.
   - Fix: `vim.diagnostic.open_float({ scope = "cursor", focusable = false })`.

## State inconsistencies

6. Staged-upgrade state is self-contradictory: `upgrade/staged-packages.json` lists
   `mise`, but `nixpkgs` and `nixpkgs-next` pins are identical
   (26.11pre1023798), so the overlay is a no-op and the once-per-day shell reminder
   will fire indefinitely.
   - Likely cause: a plain `npins update` updates `nixpkgs-next` too, silently
     invalidating an in-flight staged upgrade.
   - Fix now: clear the staged list (or re-run `hm-upgrade-begin` if the mise
     upgrade is still wanted).
   - Fix the flow: make `hm-upgrade-status` (and the daily reminder) warn
     explicitly on "staged list non-empty but pins synced", and document that
     mid-upgrade pin refreshes should be `npins update nixpkgs`, not bare
     `npins update`.

7. `zsh/functions.zsh` — `npins-shell`/`npins-run` still print usage on missing
   args and then keep executing (April finding 4). They also leak `pkg`/`cmd` as
   globals; add `local` and `return 1`.

8. Formatting drift: `alejandra --check . --exclude ./npins` fails on `setup.nix`
   and `default.nix`. One command fixes it: `alejandra setup.nix default.nix`.

9. `external/nvim/lazy-lock.json` is gitignored, so a fresh install resolves every
   plugin to latest-of-today — the classic breaks-on-fresh-install trap, and no
   reproducibility across machines. The local lockfile also still carries a stale
   `just-vim` entry precisely because it isn't tracked.
   - Fix: track the lockfile (drop it from `external/nvim/.gitignore`).

10. Local cruft to delete: empty untracked dirs `tests/` and
    `external/jjconfig_defaults/`; stale `.aider.*` files (Feb 2025) and the
    empty `.codex` file at the repo root (all gitignored, all dead).

## Hygiene and hardening

11. No check gate exists. Add a `check` task to `mise.toml` so `mise run check`
    (already aliased as `,`) runs:
    - `nix-instantiate --parse default.nix`
    - `alejandra --check . --exclude ./npins`
    - `stylua --check external/nvim`
    - `shellcheck bin/* setup/*.sh zsh/*.zsh`
    Optionally wire the same script into GitHub Actions.

12. `config/git.nix:26-32` — the empty `user.name`/`user.email` aider workaround
    (with its "remove when all machines have aider updated" TODO) is stale; aider
    has been gone since Feb 2025. Remove the block; the seeded `~/.gitconfig`
    supplies the real identity. Note the current empty strings would produce
    "empty ident" commit failures on any machine missing `~/.gitconfig`.

13. `zsh/functions.zsh:1-3` — `pipis()` is a pip-era helper with unquoted `$1`;
    likely dead, delete or harden.

14. `zsh/prezto.nix:52` — `zstyle ':completion:*' users pihsun root` hardcodes a
    username that doesn't match this machine's user (`peter`). Parameterize from
    `config.home.username` or drop.

15. `zsh/prezto.nix:38` — `ssh.identities = ["id_rsa"]` is RSA-era; most likely
    should be `id_ed25519` (or both).

16. `README.md` still says "New dotfiles repo." (Sep 2024). Point it at AGENTS.md
    and the bootstrap one-liner.

17. `config/tmux.nix` — `terminal = "screen-256color"`; `tmux-256color` is the
    modern choice and would make some of the manual `terminal-overrides` in
    `external/tmux.conf` unnecessary.

## Neovim cleanups (from the dedicated config review)

18. Deprecated APIs, still working but slated for removal:
    - `vim.diagnostic.goto_prev`/`goto_next` (`nvim-lspconfig.lua:115,121`) →
      `vim.diagnostic.jump({ count = ±1, float = true })`.
    - `vim.loop` (`init.lua:10`, `conform.lua:73`) → `vim.uv`.

19. Legacy vimscript in `init.vim` that is dead in Neovim: `t_Co`/`t_vb`, the
    entire bracketed-paste/`pastetoggle` block (lines ~231-248), the toml filetype
    autocmd, and `set lazyredraw` (known to glitch with Lua UIs). The
    `BufWritePost $MYVIMRC ... source` autocmd re-runs `lazy.setup()` and can
    duplicate autocmds; drop it.

20. Dead/overlapping plugins: `barbar.lua` is `enabled = false` but carries ~60
    lines of keymaps (its buffer-nav role is served by vim-bufsurf); the git stack
    (neogit + fugitive + diffview + gitsigns + vim-diff-enhanced + vim-diff-fold)
    overlaps substantially; several commented-out spec blocks in `plugins.lua` and
    `nvim-lspconfig.lua` can be pruned.

21. Startup cost: most of `plugins.lua` (fugitive, emmet, abolish, a pile of niche
    syntax plugins) loads eagerly; nearly all are `ft`/`cmd`-lazyloadable. There is
    already a `vim-startuptime` install and TODOs acknowledging this.

22. Machine-fragile: `nvim-lspconfig.lua:1-4` hardcodes
    `~/.bun/install/global/node_modules/@vue/typescript-plugin`; on machines
    without that exact bun layout the Vue plugin path silently dangles.

## Positive notes

- The staged nixpkgs upgrade design (overlay from `nixpkgs-next` + JSON staging
  list + shell reminder) is clean and well-documented in `docs/plans/`.
- `bin/update-shell-completions` is careful (manifest-based sync, temp dirs,
  cache invalidation), and `bin/unarchive` handles collisions atomically.
- The Neovim config is already migrated to the modern APIs (`vim.lsp.config`/
  `vim.lsp.enable`, blink.cmp, conform, Treesitter `main` branch) — rare and good.
- Four of five findings from the April review were addressed.

## Recommended order

1. Quick verified-bug fixes: tmux `bind '\'` quoting, `comment.lua` deletion,
   `vim-plugin.lua` cond return, difftastic in mise baseline, `open_float` scope.
2. Resolve the staged-upgrade inconsistency (clear or restart the mise staging)
   and add the "staged but synced" warning to `hm-upgrade-status`.
3. Track `lazy-lock.json`.
4. Add the `mise run check` task; fix the alejandra drift as part of it.
5. Shell/git hygiene: npins helpers, aider workaround removal, `pipis`,
   hardcoded completion user, ssh identity.
6. Neovim deprecation and startup cleanups, README refresh.
