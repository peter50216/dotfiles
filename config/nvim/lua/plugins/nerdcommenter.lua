return {
  {
    "scrooloose/nerdcommenter",
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDUsePlaceHolders = 0
      vim.g.NERDCustomDelimiters = { vue = { left = "//", right = "" } }
      vim.keymap.set(
        { "n", "v" },
        "\\",
        "<Plug>NERDCommenterToggle",
        { silent = true, desc = "Toggle line comment" }
      )
    end,
  },
}
