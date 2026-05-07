return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local nvim_treesitter = require("nvim-treesitter")

      nvim_treesitter.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      nvim_treesitter.install({
        "lua",
        "markdown",
        "markdown_inline",
        "typescript",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("autocmd_treesitter", {}),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
        desc = "Enable Tree-sitter highlighting when a parser is available",
      })

      -- Set up custom highlights for sig
      vim.api.nvim_set_hl(0, "@sig.call.ruby", { link = "InlayHints" })
      vim.api.nvim_set_hl(0, "@sig.block.ruby", { fg = "#5d7ca6" })
      vim.api.nvim_set_hl(0, "@assert.receiver.ruby", { link = "InlayHints" })
      vim.api.nvim_set_hl(0, "@assert.method.ruby", { link = "InlayHints" })
      vim.api.nvim_set_hl(0, "@assert.type.ruby", { fg = "#5d7ca6" })
    end,
  },
}
