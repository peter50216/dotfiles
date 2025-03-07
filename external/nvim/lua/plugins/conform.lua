return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
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
        javascript = { "eslint_d", "prettier", stop_after_first = true },
        typescript = { "eslint_d", "prettier", stop_after_first = true },
        vue = { "eslint_d", "stylelint" },
        nix = { "alejandra" },
        json = { "prettier" },
        html = { "prettier" },
        python = { "yapf" },
        ruby = { "syntax_tree", "standardrb" },
        ["html.eruby"] = { "erb_format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
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

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
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
            require_cwd = true,
          },
          stylelint = function()
            return {
              command = require("conform.util").find_executable({
                "./node_modules/.bin/stylelint",
              }, "stylelint"),
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

        format_after_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return {}
        end,
      })
    end,
  },
}
