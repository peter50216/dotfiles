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
    config = function()
      local module = require("conform")
      local au_id =
        vim.api.nvim_create_augroup("autocmd_conform", { clear = true })

      local jsts = function(bufnr)
        if string.find(vim.api.nvim_buf_get_name(bufnr), "/chromium/src/") then
          return { "clang-format" }
        else
          return { "eslint_d" }
        end
      end

      local formatters_by_ft = {
        cpp = { "clang-format" },
        lua = { "stylua" },
        javascript = jsts,
        typescript = jsts,
        vue = { "eslint_d" },
        nix = { "alejandra" },
        json = { "prettier" },
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        group = au_id,
        callback = function(args)
          local original = vim.notify
          vim.notify = function(msg, level, opts)
            original(msg, vim.log.levels.WARN, opts)
          end
          module.format({ buf = args.buf })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        group = au_id,
        callback = function()
          if formatters_by_ft[vim.bo.filetype] ~= nil then
            vim.opt_local.formatexpr = 'v:lua.require("conform").formatexpr()'
          end
        end,
      })

      module.setup({
        formatters_by_ft = formatters_by_ft,
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
      })
    end,
  },
}
