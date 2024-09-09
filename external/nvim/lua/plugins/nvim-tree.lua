return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    config = true,
    keys = {
      {
        "<S-Tab>",
        ":NvimTreeToggle<CR>",
        silent = true,
        desc = "Toggle nvim-tree",
      },
      {
        "<Leader>n",
        ":NvimTreeFindFile<CR>",
        silent = true,
        desc = "Focus current file in nvim-tree",
      },
    },
  },
}
