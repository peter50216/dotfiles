vim.g.barbar_auto_setup = false

return {
  {
    "romgrk/barbar.nvim",
    opts = {
      auto_hide = 1,
      icons = {
        button = "",
        gitsigns = {
          added = { enabled = false },
          changed = { enabled = false },
          deleted = { enabled = false },
        },
        filetype = {
          enabled = false,
        },
      },
    },
    keys = {
      {
        "Z",
        "<Cmd>BufferPrevious<CR>",
        mode = "n",
        desc = "Previous buffer",
      },
      { "X", "<Cmd>BufferNext<CR>", mode = "n", desc = "Next buffer" },
      {
        "<A-Z>",
        "<Cmd>BufferMovePrevious<CR>",
        mode = "n",
        desc = "Move buffer left",
      },
      {
        "<A-X>",
        "<Cmd>BufferMoveNext<CR>",
        mode = "n",
        desc = "Move buffer right",
      },
      { "<A-1>", "<Cmd>BufferGoto 1<CR>", mode = "n", desc = "Go to buffer 1" },
      { "<A-2>", "<Cmd>BufferGoto 2<CR>", mode = "n", desc = "Go to buffer 2" },
      { "<A-3>", "<Cmd>BufferGoto 3<CR>", mode = "n", desc = "Go to buffer 3" },
      { "<A-4>", "<Cmd>BufferGoto 4<CR>", mode = "n", desc = "Go to buffer 4" },
      { "<A-5>", "<Cmd>BufferGoto 5<CR>", mode = "n", desc = "Go to buffer 5" },
      { "<A-6>", "<Cmd>BufferGoto 6<CR>", mode = "n", desc = "Go to buffer 6" },
      { "<A-7>", "<Cmd>BufferGoto 7<CR>", mode = "n", desc = "Go to buffer 7" },
      { "<A-8>", "<Cmd>BufferGoto 8<CR>", mode = "n", desc = "Go to buffer 8" },
      { "<A-9>", "<Cmd>BufferGoto 9<CR>", mode = "n", desc = "Go to buffer 9" },
      {
        "<A-0>",
        "<Cmd>BufferLast<CR>",
        mode = "n",
        desc = "Go to last buffer",
      },
    },
  },
}
