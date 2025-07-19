return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    opts = {
      servers = {
        -- pnpm i -g vscode-langservers-extracted
        eslint = {},
        -- pnpm i -g @vue/language-server
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        -- system clangd
        clangd = {},
        -- pnpm i -g pyright
        pyright = {},
        -- go install golang.org/x/tools/gopls@latest
        gopls = {},
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruby_lsp
        ruby_lsp = {
          on_init = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
        standardrb = {},
        sorbet = {},
        -- https://github.com/oxalica/nil
        nil_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              telemetry = {
                enable = false,
              },
            },
          },
        },
        -- pnpm i -g vscode-langservers-extracted
        jsonls = {
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
        },
        -- pnpm i -g typescript-language-server
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = string.format(
                  "%s/global/5/node_modules/@vue/typescript-plugin",
                  os.getenv("PNPM_HOME")
                ),
                languages = { "vue" },
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
            "typescriptreact",
            "vue",
          },
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities =
          require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

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
