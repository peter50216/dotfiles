return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      require("harpoon.logger"):enable()
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local make_finder = function()
          local paths = {}
          for i = 1, harpoon_files:length() do
            if harpoon_files.items[i] ~= nil then
              table.insert(paths, harpoon_files.items[i].value)
            end
          end

          return require("telescope.finders").new_table({
            results = paths,
          })
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = make_finder(),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_buffer_number, map)
              map("i", "<C-d>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker =
                  state.get_current_picker(prompt_buffer_number)

                harpoon:list():remove(selected_entry)
                current_picker:refresh(make_finder())
              end)

              return true
            end,
          })
          :find()
      end

      vim.keymap.set("n", "<Leader>v", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })

      vim.keymap.set("n", "<Leader>a", function()
        harpoon:list():add()
      end)

      vim.keymap.set("n", "<Leader>1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<Leader>2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<Leader>3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<Leader>4", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<Leader>5", function()
        harpoon:list():select(5)
      end)
    end,
  },
}
