return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function(_)
      local au_id = vim.api.nvim_create_augroup("autocmd_indent_blankline", {})
      vim.api.nvim_create_autocmd("Colorscheme", {
        group = au_id,
        callback = function()
          -- vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", {
          -- bg = "#141414",
          -- })
          -- vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {
          -- fg = "#64748b",
          -- })
          -- vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", {
          -- sp = "#64748b",
          -- underline = true,
          -- })
        end,
      })
      require("ibl").setup {
        scope = {
          enabled = true,
          show_start = true,
        },
        indent = {
          char = "",
          -- highlight = {
          -- "IndentBlanklineIndent1",
          -- "IndentBlanklineIndent2",
          -- },
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
