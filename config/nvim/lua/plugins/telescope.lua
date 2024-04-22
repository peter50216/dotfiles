return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      local themes = require("telescope.themes")
      local module = require("telescope")
      local config = require("telescope.config")

      -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories
      local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      local build_opts = function(desc)
        return { silent = true, desc = desc }
      end

      vim.keymap.set(
        "n",
        "<Leader>b",
        builtin.buffers,
        build_opts("#telescope Buffers")
      )

      vim.keymap.set(
        "n",
        "<Leader><Space>",
        builtin.find_files,
        build_opts("#telescope Files")
      )

      vim.keymap.set(
        "n",
        "<Leader>l",
        builtin.current_buffer_fuzzy_find,
        build_opts("#telescope Lines in current buffer")
      )

      vim.keymap.set(
        "n",
        "<Leader>g",
        builtin.grep_string,
        build_opts("#telescope Search symbol in current folder")
      )

      vim.keymap.set("n", "<Leader>h", function()
        builtin.current_buffer_fuzzy_find({
          default_text = vim.fn.expand("<cword>"),
        })
      end, build_opts("#telescope Search symbol in current buffer"))

      vim.keymap.set(
        "n",
        "<Leader>xd",
        builtin.lsp_definitions,
        build_opts("Go to definition")
      )
      vim.keymap.set(
        "n",
        "<Leader>xt",
        builtin.lsp_type_definitions,
        build_opts("Go to type definition")
      )
      vim.keymap.set(
        "n",
        "<Leader>xi",
        builtin.lsp_implementations,
        build_opts("Go to implementation")
      )
      vim.keymap.set(
        "n",
        "<Leader>xq",
        builtin.lsp_references,
        build_opts("Go to references")
      )

      module.setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          layout_config = {
            horizontal = { width = 0.9 },
          },
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          current_buffer_fuzzy_find = {
            previewer = false,
          },
          find_files = {
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
            },
          },
        },

        extensions = {
          ["ui-select"] = {
            themes.get_cursor({}),
          },
        },
      })
      module.load_extension("fzf")
      module.load_extension("ui-select")
    end,
  },
}
