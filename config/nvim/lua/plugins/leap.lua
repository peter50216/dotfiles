return {
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").setup {}
    end,
    keys = {
      {
        "s",
        "<Plug>(leap-forward-to)",
        mode = { "n", "x", "o" },
        desc = "Leap forward to",
      },
      {
        "S",
        "<Plug>(leap-backward-to)",
        mode = { "n", "x", "o" },
        desc = "Leap backward to",
      },
    },
  },
  { "ggandor/flit.nvim", config = true },
}
