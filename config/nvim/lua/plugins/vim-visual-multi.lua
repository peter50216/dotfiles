return {
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_leader = ","
    end,
    config = function()
      vim.g.VM_mouse_mappings = 1
    end,
  },
}
