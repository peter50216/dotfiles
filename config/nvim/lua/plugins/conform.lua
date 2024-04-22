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
      local util = require("conform.util")

      local au_id =
        vim.api.nvim_create_augroup("autocmd_conform", { clear = true })

      local formatters_by_ft = {
        cpp = { "clang-format" },
        css = { "prettier", "stylelint" },
        lua = { "stylua" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        vue = { "eslint_d", "stylelint" },
        nix = { "alejandra" },
        json = { "prettier" },
        python = { "black" },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        group = au_id,
        callback = function()
          if formatters_by_ft[vim.bo.filetype] ~= nil then
            vim.opt_local.formatexpr = 'v:lua.require("conform").formatexpr()'
          end
        end,
      })

      local slow_format_filetypes = {}
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
          stylelint = function()
            return {
              command = require("conform.util").find_executable({
                "./node_modules/.bin/stylelint",
              }, "stylelint"),
              prepend_args = function()
                return { "--stdin-filename", vim.fn.expand("%:p") }
              end,
            }
          end,
          ["clang-format"] = {
            args = function(self, ctx)
              local filename = string.gsub(ctx.filename, "%.[cm]js$", ".js")
              return { "-assume-filename", filename }
            end,
            range_args = function(self, ctx)
              local filename = string.gsub(ctx.filename, "%.[cm]js$", ".js")
              local start_offset, end_offset =
                util.get_offsets_from_range(ctx.buf, ctx.range)
              local length = end_offset - start_offset
              return {
                "-assume-filename",
                filename,
                "--offset",
                tostring(start_offset),
                "--length",
                tostring(length),
              }
            end,
          },
        },

        format_on_save = function(bufnr)
          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          local original = vim.notify
          local function on_format(err)
            if err and err:match("timeout$") then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
            vim.notify = original
          end
          vim.notify = function(msg, level, opts)
            original(msg, vim.log.levels.WARN, opts)
          end

          return { timeout_ms = 200 }, on_format
        end,

        format_after_save = function(bufnr)
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return {}
        end,
      })
    end,
  },
}
