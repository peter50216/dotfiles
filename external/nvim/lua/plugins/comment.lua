return {
  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = false,
    },
    keys = {
      {
        "\\",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        silent = true,
        desc = "Toggle line comment",
      },
      {
        "\\",
        function()
          local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
          vim.api.nvim_feedkeys(esc, "nx", true)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = "v",
        silent = true,
        desc = "Toggle line comment",
      },
    },
  },
}
