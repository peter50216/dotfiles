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

  { "AndrewRadev/splitjoin.vim" },
  { "tpope/vim-endwise" },
  { "tpope/vim-surround" },

  -- TODO(Darkpi): Consider defx.nvim?
  { "Xuyuanp/nerdtree-git-plugin" },
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
    "ggandor/leap.nvim",
    config = function()
      require("leap").setup {}
      require("leap").add_default_mappings()
    end,
  },
  { "ggandor/flit.nvim", config = true },
}
