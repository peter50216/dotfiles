return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
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
      }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
      -- pnpm i -g typescript-language-server
      lspconfig.tsserver.setup({
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
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      })

      local au_id = vim.api.nvim_create_augroup("autocmd_lspconfig", {})
      vim.keymap.set(
        "n",
        "<Leader>xp",
        vim.diagnostic.goto_prev,
        { silent = true, desc = "Go to next diagnostic" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xn",
        vim.diagnostic.goto_next,
        { silent = true, desc = "Go to previous diagnostic" }
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

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf, silent = true }
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
            "<Leader>xd",
            vim.lsp.buf.definition,
            build_opts("Go to definition")
          )
          vim.keymap.set(
            "n",
            "<Leader>xt",
            "<Plug>(coc-type-definition)",
            build_opts("Go to type definition")
          )
          vim.keymap.set(
            "n",
            "<Leader>xr",
            vim.lsp.buf.rename,
            build_opts("Rename current symbol")
          )
          vim.keymap.set(
            "n",
            "<Leader>xi",
            vim.lsp.buf.implementation,
            build_opts("Go to implementation")
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, build_opts("Show doc"))
          vim.keymap.set(
            "n",
            "<Leader>xq",
            vim.lsp.buf.references,
            build_opts("Go to references")
          )
        end,
      })
    end,
  },
}
