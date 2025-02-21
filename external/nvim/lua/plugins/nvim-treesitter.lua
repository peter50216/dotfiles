return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    lazy = false,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- Set up custom highlights for sig
      vim.api.nvim_set_hl(0, "@sig.call.ruby", { link = "InlayHints" })
      vim.api.nvim_set_hl(0, "@sig.block.ruby", { fg = "#5d7ca6" })
      vim.api.nvim_set_hl(0, "@let.receiver.ruby", { link = "InlayHints" })
      vim.api.nvim_set_hl(0, "@let.method.ruby", { link = "InlayHints" })
      vim.api.nvim_set_hl(0, "@let.type.ruby", { fg = "#5d7ca6" })
    end,
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      endwise = {
        enable = true,
      },
    },
  },
}
