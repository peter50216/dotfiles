return {
  {
    "Lokaltog/vim-easymotion",
    init = function()
      vim.keymap.set(
        "",
        "<Leader>m",
        "<Plug>(easymotion-prefix)",
        { silent = true, desc = "#easymotion" }
      )
    end,
    config = function()
      vim.g.EasyMotion_move_highlight = 0
      vim.g.EasyMotion_smartcase = 1
      vim.keymap.set(
        "",
        "s",
        "<Plug>(easymotion-s2)",
        { silent = true, desc = "#easymotion Search 2 chars" }
      )
      vim.keymap.set(
        "",
        "<Leader>j",
        "<Plug>(easymotion-j)",
        { silent = true, desc = "#easymotion Move down" }
      )
      vim.keymap.set(
        "",
        "<Leader>k",
        "<Plug>(easymotion-k)",
        { silent = true, desc = "#easymotion Move up" }
      )
    end,
  },
}
