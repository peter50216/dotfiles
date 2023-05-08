return {
  {
    "junegunn/fzf.vim",
    init = function()
      vim.g.fzf_command_prefix = "FZF"
    end,
    config = function()
      vim.g.fzf_action = {
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "botright split",
        ["ctrl-v"] = "botright vsplit",
      }
      -- TODO(Darkpi): Migrate the command to lua
      vim.api.nvim_create_user_command(
        "FZFRg",
        ([[call fzf#vim#grep(
          'rg --no-heading --vimgrep '.
          '--colors path:style:bold --colors path:fg:0x81,0xa2,0xbe '.
          '--colors line:style:bold --colors line:fg:black '.
          '--colors match:fg:0x8a,0xe2,0x34 --color=always -- '.
          shellescape(<q-args>), 1,
          <bang>0 ? fzf#vim#with_preview('up:60%')
                  : fzf#vim#with_preview('right:50%:hidden', '?'),
          <bang>0)]]):gsub("\n", ""),
        { bang = true, nargs = "*" }
      )
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
      vim.keymap.set("n", "<Leader>h", ":FZFBLines <C-R><C-W><CR>", {
        silent = true,
        desc = "#fzf Search symbol in current buffer",
      })
    end,
  },
  {
    "junegunn/fzf",
  },
}
