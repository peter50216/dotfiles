return {
  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      vim.opt.termguicolors = true
    end,
    opts = {
      filetypes = {
        "*",
        css = {
          css = true,
          RRGGBBAA = true,
        },
      },
      user_default_options = {
        mode = "background",
      },
    },
  },
}
