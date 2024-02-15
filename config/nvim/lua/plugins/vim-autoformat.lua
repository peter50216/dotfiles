return {
  {
    "Chiel92/vim-autoformat",
    config = function()
      vim.g.formatdef_yapf =
      "'yapf --style=\"{based_on_style:chromium,indent_width:'.&shiftwidth.(&textwidth ? ',column_limit:'.&textwidth : '').',ALLOW_MULTILINE_LAMBDAS: true, I18N_FUNCTION_CALL: func_not__exist}\" -l '.a:firstline.'-'.a:lastline"
      vim.g.formatdef_eslint_d =
      '"eslint_d --fix --stdin --stdin-filename ".expand("%")." --fix-to-stdout"'
      vim.g.formatdef_jsbeautify_json =
      '"js-beautify -b expand,preserve-inline -i -".(&expandtab ? "s ".shiftwidth() : "t")'
      vim.g.formatdef_npx_prettier =
      '"pnpm prettier --stdin-filepath ".expand("%:p").(&textwidth ? " --print-width ".&textwidth : "")." --tab-width=".shiftwidth()'
      vim.g.formatdef_usort = '"usort format -"'
      vim.g.formatters_javascript = {
        "eslint_d",
        "npx_prettier",
        "prettier"
      }
      vim.g.formatters_typescript = {
        "eslint_d",
        "npx_prettier",
        "prettier",
      }
      vim.g.formatters_typescriptreact = { "npx_prettier", "prettier" }
      vim.g.formatters_vue = { "eslint_d", "npx_prettier", "prettier" }
      vim.g.formatters_javascript = { "clangformat" }
      vim.g.formatters_html = { "prettier" }
      vim.g.formatters_ruby = { "rubocop" }
      vim.g.formatters_python = { "black", "usort" }
      vim.g.run_all_formatters_python = 1
      vim.g.autoformat_autoindent = 0
      vim.g.autoformat_retab = 0
      vim.g.autoformat_remove_trailing_spaces = 0

      vim.keymap.set(
        "v",
        "<Leader>f",
        ":Autoformat<CR>",
        { silent = true, desc = "Format selected" }
      )
      vim.keymap.set(
        "n",
        "<Leader>f",
        "V:Autoformat<CR>",
        { silent = true, desc = "Format current line" }
      )

      local au_id = vim.api.nvim_create_augroup("autocmd_vim_autoformat", {})

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = au_id,
        pattern = { "*.vue", "*.ts", "*.cjs", "*.lua", "*.mjs", "*.mts", "*.py" },
        command = ":Autoformat",
      })
    end,
  },
}
