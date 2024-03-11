return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_transparent_background = 1
      vim.cmd [[colorscheme everforest]]
    end,
  },

  {
    "AndrewRadev/splitjoin.vim",
    cond = vim.g.vscode,
  },
  {
    "tpope/vim-endwise",
    cond = true,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    cond = true,
    config = true,
  },

  -- TODO(Darkpi): Consider defx.nvim?
  { "tpope/vim-abolish" },
  { "tpope/vim-repeat" },
  { "vim-scripts/restore_view.vim" },

  -- For ruby shortcuts
  { "hackel/vis" },
  { "tpope/vim-fugitive" },
  { "chrisbra/vim-diff-enhanced" },

  -- TODO: rewrite this in a faster language (rust? Or maybe just accept
  -- vimscript...) so the startup time can be faster.
  { "peter50216/vim-simple-statusline" },
  { dir = "~/chromium/src/tools/vim/mojom" },

  { "vim-scripts/ifdef-highlighting" },
  { "gentoo/gentoo-syntax" },
  { "mattn/emmet-vim" },
  { "sgeb/vim-diff-fold" },
  { "jyelloz/vim-dts-indent" },
  { "tmux-plugins/vim-tmux" },
  { "nvim-treesitter/playground" },
  { "https://github.com/kalcutter/vim-gn" },
  { "dstein64/vim-startuptime" },
  {
    "chrisgrieser/nvim-various-textobjs",
    opts = {
      useDefaultKeymaps = true,
    },
  },
  { "RaafatTurki/hex.nvim", config = true },
  {
    "klen/nvim-config-local",
    main = "config-local",
    opts = {
      config_files = { ".lvimrc" },
      lookup_parents = true,
      autocommands_create = true,
      commands_create = true,
    },
  },
  { "isobit/vim-caddyfile" },
  { "vmchale/just-vim" },
}
