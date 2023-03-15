return {
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_no_mappings = 1
    end,
    config = function()
      vim.g.slime_target = "tmux"
      vim.keymap.set(
        "v",
        "<Leader>ss",
        "<Plug>SlimeRegionSend",
        { silent = true, desc = "Send region to tmux" }
      )
      vim.keymap.set(
        "n",
        "<Leader>ss",
        "<Plug>SlimeParagraphSend",
        { silent = true, desc = "Send paragraph to tmux" }
      )
      vim.keymap.set(
        "n",
        "<Leader>sc",
        "<Plug>SlimeConfig",
        { silent = true, desc = "Config send to tmux target" }
      )
    end,
  },
}
