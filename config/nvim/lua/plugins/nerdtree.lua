return {
  {
    "scrooloose/nerdtree",
    config = function()
      vim.g.NERDTreeWinSize = 24
      vim.g.NERDTreeIgnore = {
        "\\.o$",
        "\\.a$",
        "\\.d$[[file]]",
        "\\.pyc",
        "\\.swo",
        "\\.swp",
        "\\.un\\~",
        "\\.un",
        "\\.git$[[dir]]",
      }

      local au_id = vim.api.nvim_create_augroup("autocmd_nerdtree", {})
      vim.api.nvim_create_autocmd("BufEnter", {
        group = au_id,
        command = "if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif",
      })
    end,
    keys = {
      {
        "<S-Tab>",
        ":NERDTreeToggle<CR>",
        silent = true,
        desc = "Toggle NERDTree",
      },
      {
        "<Leader>n",
        ":NERDTreeFind<CR>:wincmd p<CR>",
        silent = true,
        desc = "Focus current file in NERDTree",
      },
    },
  },
  { "Xuyuanp/nerdtree-git-plugin" },
}
