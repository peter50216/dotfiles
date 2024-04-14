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
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = au_id,
        callback = function()
          require("lint").try_lint()
        end,
      })
      module.linters.stylelint.stream = "stderr"
    end,
  },
}
