return {
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
}
