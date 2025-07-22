return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        tsserver = {
          enabled = false,
        },
      },
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "folke/snacks.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          tsserver_file_preferences = {
            importModuleSpecifierPreference = "relative",
            preferTypeOnlyAutoImports = true,
          },
        },
      })
      -- Keep all your existing keybindings for imports
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact" },
        callback = function()
          vim.keymap.set("n", "<leader>io", "<cmd>TSToolsOrganizeImports<CR>", { buffer = true, desc = "[O]rganize" })
          vim.keymap.set(
            "n",
            "<leader>ia",
            "<cmd>TSToolsAddMissingImports<CR>",
            { buffer = true, desc = "[A]dd missing" }
          )
          vim.keymap.set(
            "n",
            "<leader>ir",
            "<cmd>TSToolsRemoveUnusedImports<CR>",
            { buffer = true, desc = "[R]emove unused" }
          )
          vim.keymap.set("n", "<leader>is", "<cmd>TSToolsSortImports<CR>", { buffer = true, desc = "[S]ort" })
          vim.keymap.set("n", "<leader>if", "<cmd>TSToolsFixAll<CR>", { buffer = true, desc = "[F]ix All" })
        end,
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
        hi = {
          arrow = "DiagnosticInfo",
        },
        options = {
          show_source = {
            if_many = true,
          },
          multilines = {
            enabled = true,
            always_show = true,
          },
          enable_on_insert = true,
          set_arrow_to_diag_color = true,
          throttle = 10,
          format = function(diagnostic)
            if diagnostic.source then
              return " [" .. diagnostic.source .. "] " .. diagnostic.message
            end
            return diagnostic.message
          end,
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}
