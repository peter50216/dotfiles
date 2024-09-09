return {
  {
    "tpope/vim-eunuch",
    config = function()
      vim.keymap.set("c", "w!!", "SudoWrite", { desc = "Expand SudoWrite" })
    end,
  },
}
