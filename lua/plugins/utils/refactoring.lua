return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("refactoring").setup({
        vim.keymap.set({ "n", "x" }, "<leader>re",
          function() return require('refactoring').refactor('Extract Function') end,
          { desc = "Extract Func", expr = true }),
        vim.keymap.set({ "n", "x" }, "<leader>rf",
          function() return require('refactoring').refactor('Extract Function To File') end,
          { desc = "Extract Func To File", expr = true }),
        vim.keymap.set({ "n", "x" }, "<leader>rv",
          function() return require('refactoring').refactor('Extract Variable') end,
          { desc = "Extract Variable", expr = true }),
        vim.keymap.set({ "n", "x" }, "<leader>rI",
          function() return require('refactoring').refactor('Inline Function') end,
          { desc = "Inline Function", expr = true }),
        vim.keymap.set({ "n", "x" }, "<leader>ri",
          function() return require('refactoring').refactor('Inline Variable') end,
          { desc = "Inline Variable", expr = true }),
        vim.keymap.set({ "n", "x" }, "<leader>rbb",
          function() return require('refactoring').refactor('Extract Block') end, { desc = "Extract Block", expr = true }),
        vim.keymap.set({ "n", "x" }, "<leader>rbf",
          function() return require('refactoring').refactor('Extract Block To File') end,
          { desc = "Extract Block to File", expr = true }),
      })
    end,
  },
}
