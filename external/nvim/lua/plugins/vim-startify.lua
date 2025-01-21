return {
  {
    "mhinz/vim-startify",
    enabled = false,
    config = function()
      vim.g.startify_change_to_dir = 0
      vim.g.startify_custom_header = {}
    end,
  },
}
