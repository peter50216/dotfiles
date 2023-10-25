return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function(_)
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", {
          fg = "#101810",
        })
        vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", {
          fg = "#101020",
        })
      end)
      require("ibl").setup {
        scope = {
          enabled = false,
        },
        indent = {
          highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
          },
        },
        exclude = {
          filetypes = {
            "lspinfo",
            "packer",
            "checkhealth",
            "help",
            "man",
            "startify",
            "",
          },
        },
      }
    end,
  },
}
