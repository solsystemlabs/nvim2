-- Utility plugins

return {
  {
    "tenxsoydev/karen-yank.nvim",
    event = "TextYankPost",
    config = function()
      require("karen-yank").setup()
    end,
  },
  {
    "nvim-mini/mini.move",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",

        -- Move current line in Normal mode
        line_left = "<A-h>",
        line_right = "<A-l>",
        line_down = "<A-j>",
        line_up = "<A-k>",
      },
    },
  },
  {
    "mbbill/undotree",
    config = function()
      vim.opt.undofile = true
      vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_DiffAutoOpen = 1
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_DiffCommand = "diff"
    end,
  },
  {
    {
      "mawkler/jsx-element.nvim",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      ft = { "typescriptreact", "javascriptreact", "javascript" },
      opts = {},
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    cmd = "NoNeckPain",
    keys = {
      { "<leader>p", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain" },
    },
    opts = {
      width = 160,
    },
  },
}
