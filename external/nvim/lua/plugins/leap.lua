return {
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      local function ft(kwargs)
        require("leap").leap(vim.tbl_deep_extend("keep", kwargs, {
          inputlen = 1,
          inclusive = true,
          opts = {
            -- Force autojump.
            labels = "",
            -- Match the modes where you don't need labels (`:h mode()`).
            safe_labels = vim.fn.mode(1):match("no?") and "" or nil,
          },
        }))
      end

      local clever = require("leap.user").with_traversal_keys
      local clever_f, clever_t = clever("f", "F"), clever("t", "T")
      vim.keymap.set(
        { "n", "x", "o" },
        "s",
        "<Plug>(leap-forward)",
        { desc = "Leap forward" }
      )
      vim.keymap.set(
        { "n", "x", "o" },
        "S",
        "<Plug>(leap-backward)",
        { desc = "Leap backward" }
      )
      vim.keymap.set({ "n", "x", "o" }, "f", function()
        ft({ opts = clever_f })
      end, { desc = "Find forward" })
      vim.keymap.set({ "n", "x", "o" }, "F", function()
        ft({ backward = true, opts = clever_f })
      end, { desc = "Find backward" })
      vim.keymap.set({ "n", "x", "o" }, "t", function()
        ft({ offset = -1, opts = clever_t })
      end, { desc = "Find forward to" })
      vim.keymap.set({ "n", "x", "o" }, "T", function()
        ft({ backward = true, offset = 1, opts = clever_t })
      end, { desc = "Find backward to" })
    end,
  },
}
