vim.g.mapleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------
-- Lazy.nvim {{{
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = {
    colorscheme = { "everforest" },
  },
  change_detection = {
    notify = false,
  },
  defaults = {
    cond = not vim.g.vscode,
  },
})
-- }}}

if vim.g.vscode then
  -- Emulation of some plugin specific shortcuts in vscode.
  vim.keymap.set(
    "n",
    "<Leader>xd",
    "<Cmd>call VSCodeCall('editor.action.revealDefinition')<CR>",
    { silent = true, desc = "Go to definition" }
  )
  vim.keymap.set(
    "n",
    "<Leader>xa",
    "<Cmd>call VSCodeCall('editor.action.quickFix')<CR>",
    { silent = true, desc = "Quickfix" }
  )
  vim.keymap.set(
    "n",
    "<Leader>xr",
    "<Cmd>call VSCodeCall('editor.action.rename')<CR>",
    { silent = true, desc = "Rename" }
  )
  vim.keymap.set(
    "n",
    "<Leader><Space>",
    "<Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>",
    { silent = true, desc = "Quick open" }
  )
  vim.keymap.set(
    "n",
    "Z",
    "<Cmd>call VSCodeCall('workbench.action.previousEditor')<CR>",
    { silent = true, desc = "Previous window" }
  )
  vim.keymap.del("n", "ZQ")
  vim.keymap.del("n", "ZZ")
  vim.keymap.set(
    "n",
    "X",
    "<Cmd>call VSCodeCall('workbench.action.nextEditor')<CR>",
    { silent = true, desc = "Next window" }
  )
  vim.keymap.set(
    "n",
    "<Leader>f",
    "<Cmd>call VSCodeCall('editor.action.formatDocument')<CR>",
    { silent = true, desc = "Autoformat" }
  )
  vim.keymap.set(
    "n",
    "K",
    "<Cmd>call VSCodeCall('editor.action.showHover')<CR>",
    { silent = true, desc = "Show document" }
  )
end
