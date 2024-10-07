return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = { snippet = false } },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local servers = {
        -- TODO: mason
        -- pnpm i -g vscode-langservers-extracted
        "eslint",
        -- pnpm i -g @vue/language-server
        "volar",
        -- system clangd
        "clangd",
        -- pnpm i -g pyright
        "pyright",
        -- go install golang.org/x/tools/gopls@latest
        "gopls",
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruby_lsp
        "ruby_lsp",
        -- https://github.com/oxalica/nil
        "nil_ls",
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            telemetry = {
              enable = false,
            },
          },
        },
      })
      -- pnpm i -g vscode-langservers-extracted
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
              },
              {
                fileMatch = { "tsconfig.json" },
                url = "https://json.schemastore.org/tsconfig.json",
              },
            },
          },
        },
      })
      -- pnpm i -g typescript-language-server
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = string.format(
                "%s/global/5/node_modules/@vue/typescript-plugin",
                os.getenv("PNPM_HOME")
              ),
              languages = { "javascript", "typescript", "vue" },
            },
          },
          tsserver = {
            fallbackPath = string.format(
              "%s/global/5/node_modules/typescript/lib",
              os.getenv("PNPM_HOME")
            ),
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      })
      -- pnpm i -g css-variables-language-server
      -- lspconfig.css_variables.setup({
      --   capabilities = capabilities,
      --   filetypes = {
      --     "css",
      --     "javascript",
      --     "typescript",
      --     "vue",
      --   },
      -- })

      local au_id = vim.api.nvim_create_augroup("autocmd_lspconfig", {})
      vim.keymap.set(
        "n",
        "<Leader>xp",
        vim.diagnostic.goto_prev,
        { silent = true, desc = "Go to previous diagnostic" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xn",
        vim.diagnostic.goto_next,
        { silent = true, desc = "Go to next diagnostic" }
      )

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        float = { border = "rounded" },
      })

      vim.api.nvim_create_autocmd("CursorHold", {
        group = au_id,
        callback = function()
          for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
              return
            end
          end
          vim.diagnostic.open_float({ "cursor", focusable = false })
        end,
        desc = "Open floating diagnostic under cursor on CursorHold",
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = au_id,
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local build_opts = function(desc)
            return { buffer = ev.buf, silent = true, desc = desc }
          end
          vim.keymap.set(
            { "n", "v" },
            "<Leader>xa",
            vim.lsp.buf.code_action,
            build_opts("Code action")
          )
          vim.keymap.set(
            "n",
            "<Leader>xr",
            vim.lsp.buf.rename,
            build_opts("Rename current symbol")
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, build_opts("Show doc"))
        end,
      })
    end,
  },
}
