-- Emulation of some plugin specific shortcuts in vscode.
vim.keymap.set(
  "n",
  "<Leader>xd",
  "<Cmd>call VSCodeCall('editor.action.revealDefinition')<CR>",
  { silent = true, desc = "Go to definition" }
)
vim.keymap.set(
  "n",
  "<Leader>xa",
  "<Cmd>call VSCodeCall('editor.action.quickFix')<CR>",
  { silent = true, desc = "Quickfix" }
)
vim.keymap.set(
  "n",
  "<Leader>xr",
  "<Cmd>call VSCodeCall('editor.action.rename')<CR>",
  { silent = true, desc = "Rename" }
)
vim.keymap.set(
  "n",
  "<Leader><Space>",
  "<Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>",
  { silent = true, desc = "Quick open" }
)
vim.keymap.set(
  "n",
  "Z",
  "<Cmd>call VSCodeCall('workbench.action.previousEditor')<CR>",
  { silent = true, desc = "Previous window" }
)
vim.keymap.del("n", "ZQ")
vim.keymap.del("n", "ZZ")
vim.keymap.set(
  "n",
  "X",
  "<Cmd>call VSCodeCall('workbench.action.nextEditor')<CR>",
  { silent = true, desc = "Next window" }
)
vim.keymap.set(
  "n",
  "<Leader>f",
  "<Cmd>call VSCodeCall('editor.action.formatDocument')<CR>",
  { silent = true, desc = "Autoformat" }
)
vim.keymap.set(
  "n",
  "K",
  "<Cmd>call VSCodeCall('editor.action.showHover')<CR>",
  { silent = true, desc = "Show document" }
)
