return {
  {
    "wellle/targets.vim",
    config = function()
      local au_id = vim.api.nvim_create_augroup("autocmd_targets", {})

      vim.api.nvim_create_autocmd("User", {
        pattern = "targets#mappings#user",
        group = au_id,
        command = ([[
          call targets#mappings#extend({
            'a': {'argument': [{'o': '[({[]', 'c': '[]})]', 's': ','}]}
          })
        ]]):gsub("\n", ""),
      })
    end,
    cond = true,
  },
}
