return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        vue = { "eslint_d" },
        nix = { "alejandra" },
        json = { "prettier" },
      },
      formatters = {
        stylua = function()
          return {
            prepend_args = {
              "--indent-type",
              "Spaces",
              "--indent-width",
              vim.bo.shiftwidth,
              "--column-width",
              "80",
            },
          }
        end,
        eslint_d = {
          env = {
            ESLINT_USE_FLAT_CONFIG = "true",
          },
        },
      },
      format_on_save = {
        async = true,
      },
    },
  },
}
