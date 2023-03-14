return {
  -- {{{ Colorscheme
  { "sainnhe/everforest", lazy = false, priority = 1000 },
  -- }}}

  -- Completions and diagnosis {{{
  {
    "neoclide/coc.nvim",
    branch = "release",
  },
  -- TODO(Darkpi): Check builtin lsp support
  -- ref: https://blog.inkdrop.info/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
  --  'neovim/nvim-lspconfig'
  -- }}}

  -- Fast formatting & moving around {{{
  { "AndrewRadev/splitjoin.vim" },
  {
    "Lokaltog/vim-easymotion",
    config = function()
      vim.g.EasyMotion_move_highlight = 0
      vim.g.EasyMotion_smartcase = 1
      vim.keymap.set("", "<Leader>m", "<Plug>(easymotion-prefix)")
      vim.keymap.set("", "s", "<Plug>(easymotion-s2)")

      -- map <Leader>j <Plug>(easymotion-j)
      -- map <Leader>k <Plug>(easymotion-k)
    end,
  },
  { "Raimondi/delimitMate" },
  {
    "scrooloose/nerdcommenter",
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDUsePlaceHolders = 0
      vim.g.NERDCustomDelimiters = { vue = { left = "//", right = "" } }
      vim.keymap.set({ "n", "v" }, "\\", "<Plug>NERDCommenterToggle")
    end,
  },
  { "sickill/vim-pasta" },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_leader = ","
    end,
    config = function()
      vim.g.VM_mouse_mappings = 1
    end,
  },
  { "tpope/vim-endwise" },
  { "tpope/vim-surround" },
  { "wellle/targets.vim" },
  { "Chiel92/vim-autoformat", lazy = false },
  -- { "unblevable/quick-scope", lazy = false },
  -- }}}

  -- Buffers {{{
  { "ton/vim-bufsurf" },
  -- }}}

  -- Misc {{{
  -- TODO(Darkpi): Consider defx.nvim?
  { "Konfekt/FastFold" },
  { "mhinz/vim-signify" },
  { "jpalardy/vim-slime" },
  { "mbbill/undotree" },
  { "mhinz/vim-startify" },
  { "scrooloose/nerdtree" },
  { "Xuyuanp/nerdtree-git-plugin" },
  { "tpope/vim-abolish" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-repeat" },
  { "vim-scripts/restore_view.vim" },
  -- For ruby shortcuts below
  { "hackel/vis" },
  { "tpope/vim-fugitive" },
  { "chrisbra/vim-diff-enhanced" },
  { "peter50216/vim-plugin" },

  -- TODO: rewrite this in a faster language (rust? Or maybe just accept
  -- vimscript...) so the startup time can be faster.
  { "peter50216/vim-simple-statusline", lazy = false, priority = 1000 },
  { dir = "~/chromium/src/tools/vim/mojom" },
  -- }}}

  -- To consider list {{{
  --  'mtth/scratch.vim'
  --  'nvim-telescope/telescope.nvim'
  -- }}}

  -- Language syntax/indent/compile/etc. {{{
  { "vim-scripts/ifdef-highlighting" },
  { "gentoo/gentoo-syntax" },
  { "mattn/emmet-vim" },
  { "plasticboy/vim-markdown" },
  { "sgeb/vim-diff-fold" },
  { "jyelloz/vim-dts-indent" },
  { "tmux-plugins/vim-tmux" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
  },
  { "nvim-treesitter/playground" },
  { "https://github.com/kalcutter/vim-gn" },
  -- }}}
}
