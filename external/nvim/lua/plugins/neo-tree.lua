return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
      close_if_last_window = true,
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "▸",
          expander_expanded = "▾",
        },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "#",
            ignored = "~",
            unstaged = "*",
            staged = "+",
            conflict = "?",
          },
        },
      },
      window = {
        width = 24,
      },
      -- This is the default renderers, with icon removed.
      -- :lua require('neo-tree').paste_default_config()
      renderers = {
        directory = {
          { "indent" },
          { "current_filter" },
          { "name", use_git_status_colors = false },
          {
            "symlink_target",
            highlight = "NeoTreeSymbolicLinkTarget",
          },
        },
        file = {
          { "indent" },
          { "modified" },
          { "diagnostics" },
          { "git_status" },
          {
            "name",
          },
          {
            "symlink_target",
            highlight = "NeoTreeSymbolicLinkTarget",
          },
        },
      },
    },
    keys = {
      {
        "<S-Tab>",
        ":Neotree toggle<CR>",
        silent = true,
        desc = "Toggle NERDTree",
      },
      {
        "<Leader>n",
        ":Neotree reveal<CR>:wincmd p<CR>",
        silent = true,
        desc = "Focus current file in NERDTree",
      },
    },
  },
}
