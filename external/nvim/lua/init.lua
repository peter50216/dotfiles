vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------
-- Lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  -- Keep the per-machine lockfile out of the dotfiles repo.
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  install = {
    colorscheme = { "everforest" },
  },
  change_detection = {
    notify = false,
  },
  defaults = {
    cond = not vim.g.vscode,
  },
  concurrency = 8,
})
-- }}}

local au_id = vim.api.nvim_create_augroup("autocmd_local", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.css", "*.html" },
  group = au_id,
  callback = function()
    vim.opt.iskeyword:append("-")
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.bp",
  group = au_id,
  callback = function()
    vim.bo.syntax = "json5"
  end,
})

if vim.g.vscode then
  require("my.vscode")
end
