return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
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
          {
            "container",
            content = {
              { "name", zindex = 10, use_git_status_colors = false },
              {
                "symlink_target",
                zindex = 10,
                highlight = "NeoTreeSymbolicLinkTarget",
              },
              { "clipboard", zindex = 10 },
              {
                "diagnostics",
                errors_only = true,
                zindex = 20,
                align = "right",
                hide_when_expanded = true,
              },
              {
                "git_status",
                zindex = 10,
                align = "right",
                hide_when_expanded = true,
              },
              { "file_size", zindex = 10, align = "right" },
              { "type", zindex = 10, align = "right" },
              { "last_modified", zindex = 10, align = "right" },
              { "created", zindex = 10, align = "right" },
            },
          },
        },
        file = {
          { "indent" },
          {
            "container",
            content = {
              {
                "name",
                zindex = 10,
              },
              {
                "symlink_target",
                zindex = 10,
                highlight = "NeoTreeSymbolicLinkTarget",
              },
              { "clipboard", zindex = 10 },
              { "bufnr", zindex = 10 },
              { "modified", zindex = 20, align = "right" },
              { "diagnostics", zindex = 20, align = "right" },
              { "git_status", zindex = 10, align = "right" },
              { "file_size", zindex = 10, align = "right" },
              { "type", zindex = 10, align = "right" },
              { "last_modified", zindex = 10, align = "right" },
              { "created", zindex = 10, align = "right" },
            },
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
