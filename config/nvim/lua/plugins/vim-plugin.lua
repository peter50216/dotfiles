return {
  {
    -- TODO(Darkpi): The lvimrc support use python3 which slows down startup time
    -- a LOT (200ms).
    "peter50216/vim-plugin",
    config = function()
      vim.keymap.set("n", "<Leader>occ", "<Plug>CopyCrosURLWithHash", {
        silent = true,
        desc = "Copy URL of current (CrOS) file with commit hash from gerrit",
      })

      vim.keymap.set("n", "<Leader>ocm", "<Plug>CopyCrosURL", {
        silent = true,
        desc = "Copy URL of current (CrOS) file from gerrit",
      })
    end,
  },
}
