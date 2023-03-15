return {
  -- TODO(Darkpi): Check builtin lsp support
  -- ref: https://blog.inkdrop.info/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
  -- https://www.reddit.com/r/neovim/comments/p3ji6d/nvimlspconfig_or_cocnvim/
  --  'neovim/nvim-lspconfig'
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      local au_id = vim.api.nvim_create_augroup("autocmd_coc", {})

      vim.api.nvim_create_autocmd("Colorscheme", {
        group = au_id,
        callback = function()
          vim.api.nvim_set_hl(0, "CocUnusedHighlight", {
            fg = "#A1A1A1",
            bg = "NONE",
            ctermfg = 248,
            ctermbg = "NONE",
          })
        end,
      })

      vim.api.nvim_create_autocmd("CursorHold", {
        group = au_id,
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold",
      })

      function _G.check_back_space()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
      end

      local opts = vim.keymap.set(
        "i",
        "<TAB>",
        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        { silent = true, expr = true, replace_keycodes = false, desc = "tab" }
      )
      vim.keymap.set(
        "i",
        "<S-TAB>",
        [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
        {
          silent = true,
          expr = true,
          replace_keycodes = false,
          desc = "shift-tab",
        }
      )

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand "<cword>"
        if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command("h " .. cw)
        elseif vim.api.nvim_eval "coc#rpc#ready()" then
          vim.fn.CocActionAsync "doHover"
        else
          vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
        end
      end
      vim.keymap.set(
        "n",
        "K",
        "<CMD>lua _G.show_docs()<CR>",
        { silent = true, desc = "Show doc" }
      )

      vim.keymap.set(
        "n",
        "<Leader>xf",
        "<Plug>(coc-diagnostic-info)",
        { silent = true, desc = "Show diagnostic info on current position" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xa",
        "<Plug>(coc-codeaction)",
        { silent = true, desc = "Code action" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xx",
        "<Plug>(coc-fix-current)",
        { silent = true, desc = "Auto fix on current position" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xd",
        "<Plug>(coc-definition)",
        { silent = true, desc = "Go to definition" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xt",
        "<Plug>(coc-type-definition)",
        { silent = true, desc = "Go to type definition" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xr",
        "<Plug>(coc-rename)",
        { silent = true, desc = "Rename current symbol" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xi",
        "<Plug>(coc-implementation)",
        { silent = true, desc = "Go to implementation" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xq",
        "<Plug>(coc-references)",
        { silent = true, desc = "Go to references" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xn",
        "<Plug>(coc-diagnostic-next)",
        { silent = true, desc = "Go to next diagnostic" }
      )
      vim.keymap.set(
        "n",
        "<Leader>xp",
        "<Plug>(coc-diagnostic-prev)",
        { silent = true, desc = "Go to previous diagnostic" }
      )
    end,
  },
}
