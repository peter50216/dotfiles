return {
  {
    "sickill/vim-pasta",
    config = function()
      vim.g.pasta_disabled_filetypes = {
        "python",
        "coffee",
        "markdown",
        "yaml",
        "slim",
        "nerdtree",
        "make",
        "gitsendemail",
      }
    end,
  },
}
