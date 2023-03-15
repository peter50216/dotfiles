return {
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set(
        "n",
        "<Leader>u",
        ":UndotreeToggle<CR>",
        { silent = true, desc = "Toggle undo tree" }
      )
    end,
  },
}
