return {
  {
    "ton/vim-bufsurf",
    config = function()
      vim.keymap.set(
        "n",
        "Z",
        ":BufSurfBack<CR>",
        { silent = true, desc = "Switch to previous buffer" }
      )
      vim.keymap.set(
        "n",
        "X",
        ":BufSurfForward<CR>",
        { silent = true, desc = "Switch to next buffer" }
      )
    end,
  },
}
