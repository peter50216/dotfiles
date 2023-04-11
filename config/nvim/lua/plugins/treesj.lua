return {
  {
    "Wansmer/treesj",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "gS",
        function()
          require("treesj").split()
        end,
        silent = true,
        desc = "Split block",
      },
      {
        "gJ",
        function()
          require("treesj").join()
        end,
        silent = true,
        desc = "Join block",
      },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
