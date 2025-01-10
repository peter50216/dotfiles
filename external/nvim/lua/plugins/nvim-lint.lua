return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local module = require("lint")
      local au_id =
        vim.api.nvim_create_augroup("autocmd_lint", { clear = true })

      module.linters_by_ft = {
        vue = { "stylelint" },
        css = { "stylelint" },
        ruby = { "standardrb" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufRead" }, {
        group = au_id,
        callback = function()
          require("lint").try_lint()
        end,
      })

      -- https://github.com/mfussenegger/nvim-lint/pull/518
      module.linters.stylelint.stream = "stderr"
      module.linters.stylelint.args = {
        "-f",
        "json",
        "--allow-empty-input",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.fn.expand("%:p")
        end,
      }
      module.linters.stylelint.parser = function(output)
        local status, decoded = pcall(vim.json.decode, output)
        if status then
          if decoded ~= nil and #decoded >= 1 then
            decoded = decoded[1]
          else
            decoded = {}
          end
        else
          decoded = {
            warnings = {
              {
                line = 1,
                column = 1,
                text = "Stylelint error, run `stylelint "
                  .. vim.fn.expand("%")
                  .. "` for more info.",
                severity = "error",
                rule = "none",
              },
            },
            errored = true,
          }
        end
        local diagnostics = {}
        local severities = {
          warning = vim.diagnostic.severity.WARN,
          error = vim.diagnostic.severity.ERROR,
        }
        if decoded.errored then
          for _, message in ipairs(decoded.warnings) do
            table.insert(diagnostics, {
              lnum = message.line - 1,
              col = message.column - 1,
              end_lnum = message.line - 1,
              end_col = message.column - 1,
              message = message.text,
              code = message.rule,
              user_data = {
                lsp = {
                  code = message.rule,
                },
              },
              severity = severities[message.severity],
              source = "stylelint",
            })
          end
        end
        return diagnostics
      end
    end,
  },
}
