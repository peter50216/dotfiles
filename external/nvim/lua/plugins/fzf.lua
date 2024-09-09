return {
  {
    "junegunn/fzf.vim",
    enabled = false,
    init = function()
      vim.g.fzf_command_prefix = "FZF"
    end,
    config = function()
      vim.g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "botright split",
        ["ctrl-v"] = "botright vsplit",
      }
      vim.keymap.set(
        "n",
        "<Leader>b",
        ":FZFBuffers<CR>",
        { silent = true, desc = "#fzf Buffers" }
      )
      vim.keymap.set(
        "n",
        "<Leader><Space>",
        ":FZFFiles<CR>",
        { silent = true, desc = "#fzf Files" }
      )
      vim.keymap.set(
        "n",
        "<Leader>l",
        ":FZFBLines<CR>",
        { silent = true, desc = "#fzf Lines in current buffer" }
      )
      vim.keymap.set("n", "<Leader>g", "m':FZFRg <C-R><C-W><CR>", {
        silent = true,
        desc = "#fzf Search symbol in current folder",
      })
      vim.keymap.set("n", "<Leader>h", "m':FZFBLines <C-R><C-W><CR>", {
        silent = true,
        desc = "#fzf Search symbol in current buffer",
      })
    end,
  },
  {
    "junegunn/fzf",
  },
}
