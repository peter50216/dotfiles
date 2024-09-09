return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    lazy = false,
    opts = {
      highlight = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
    },
  },
}
