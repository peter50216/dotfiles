return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function(_)
      local au_id = vim.api.nvim_create_augroup("autocmd_indent_blankline", {})
      vim.api.nvim_create_autocmd("Colorscheme", {
        group = au_id,
        callback = function()
          vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", {
            bg = "#141414",
          })
          vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {
            fg = "#64748b",
          })
          vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", {
            sp = "#64748b",
            underline = true,
          })
        end,
      })
      require("indent_blankline").setup {
        char = "",
        show_current_context = true,
        show_current_context_start = true,
        use_treesitter = true,
        max_indent_increase = 1,
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        filetype_exclude = {
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "startify",
          "",
        },
      }
    end,
  },
}
