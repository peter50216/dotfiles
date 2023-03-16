return {
  {
    "norcalli/nvim-colorizer.lua",
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = {
      "*",
      css = { css = true },
    },
  },
}
