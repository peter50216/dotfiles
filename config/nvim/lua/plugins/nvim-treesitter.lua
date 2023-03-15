return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      highlight = {
        enable = true,
        disable = { "ruby", "json" },
      },
    },
  },
}
