return {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig"
  },
  config = function()
    require("typescript-tools").setup({
      settings = {
        -- Add this to prevent duplicate results
        separate_diagnostic_server = true,
        -- Keep your original preferences
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
        -- Create a submenu under <leader>i for imports
        vim.keymap.set("n", "<leader>io", "<cmd>TSToolsOrganizeImports<CR>",
          { buffer = true, desc = "[I]mports: [O]rganize" })
        vim.keymap.set("n", "<leader>ia", "<cmd>TSToolsAddMissingImports<CR>",
          { buffer = true, desc = "[I]mports: [A]dd missing" })
        vim.keymap.set("n", "<leader>ir", "<cmd>TSToolsRemoveUnusedImports<CR>",
          { buffer = true, desc = "[I]mports: [R]emove unused" })
        vim.keymap.set("n", "<leader>is", "<cmd>TSToolsSortImports<CR>",
          { buffer = true, desc = "[I]mports: [S]ort" })
        -- Fix all shortcut that runs commands in specific order
        vim.keymap.set("n", "<leader>if", function()
          -- 1. Import missing
          vim.cmd("TSToolsAddMissingImports")
          -- 2. Remove extra
          vim.cmd("TSToolsRemoveUnusedImports")
          -- 3. Organize imports
          vim.cmd("TSToolsOrganizeImports")
          -- 4. Sort imports
          vim.cmd("TSToolsSortImports")
        end, { buffer = true, desc = "[I]mports: [F]ix all" })
      end
    })
  end
}
