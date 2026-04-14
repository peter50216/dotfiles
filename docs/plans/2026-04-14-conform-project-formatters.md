# Conform Project Formatter Overrides Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Let Conform keep repo-wide defaults while allowing untracked per-project formatter overrides for JS-family files and only enabling CSS `stylelint` when the formatter is actually available.

**Architecture:** Extend the existing `external/nvim/lua/plugins/conform.lua` config with small resolver helpers. JS-family filetypes will share one resolver that prefers project-local overrides, then checks for eslint config files, then falls back to `prettier`; CSS will use a resolver that only appends `stylelint` when Conform reports it as available.

**Tech Stack:** Neovim Lua, `stevearc/conform.nvim`

---

### Task 1: Add formatter resolver helpers

**Files:**
- Modify: `external/nvim/lua/plugins/conform.lua`

**Step 1: Add a helper to normalize override values**

Accept either a string formatter name or a list of formatter names and always return a list.

**Step 2: Add project-local override helpers**

Support both:
- `vim.g.conform_web_formatter` for one shared JS/Vue override
- `vim.g.conform_ft_overrides[filetype]` for per-filetype overrides

**Step 3: Add simple eslint config detection**

Search upward from the current buffer for:
- `eslint.config.js`
- `eslint.config.cjs`
- `eslint.config.mjs`
- `eslint.config.ts`
- `.eslintrc`
- `.eslintrc.js`
- `.eslintrc.cjs`
- `.eslintrc.json`
- `.eslintrc.yaml`
- `.eslintrc.yml`

### Task 2: Use dynamic formatter selection

**Files:**
- Modify: `external/nvim/lua/plugins/conform.lua`

**Step 1: Replace static JS-family entries with resolver functions**

Apply the same resolver to:
- `javascript`
- `typescript`
- `typescriptreact`
- `vue`

**Step 2: Make CSS conditional**

Return `{ "prettier", "stylelint" }` only when `stylelint` is available for the buffer; otherwise return `{ "prettier" }`.

### Task 3: Verify and document usage

**Files:**
- Modify: `external/nvim/lua/plugins/conform.lua`

**Step 1: Add short inline comments where the project-local override contract is not obvious**

Keep comments limited to the public knobs users will set in `.nvim.lua`.

**Step 2: Run lightweight verification**

Run:
- `luac -p external/nvim/lua/plugins/conform.lua`
- a headless Neovim load of the plugin spec file to confirm it parses cleanly

**Step 3: Summarize usage for the user**

Show examples for:
- `vim.g.conform_web_formatter = "prettier"`
- `vim.g.conform_ft_overrides = { typescript = "eslint_d" }`
