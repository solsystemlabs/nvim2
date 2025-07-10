return {
  "fedepujol/move.nvim",
  config = function()
    require("move").setup({
      line = {
        enable = true, -- Enables line movement
        indent = true  -- Toggles indentation
      },
      block = {
        enable = true, -- Enables block movement
        indent = true  -- Toggles indentation
      },
      word = {
        enable = true, -- Enables word movement
      },
      char = {
        enable = true, -- Enables char movement
      },
    })
  end,
  keys = {
    -- Line movement
    { "<M-j>",      "<cmd>MoveLine(1)<cr>",    desc = "Move line down" },
    { "<M-k>",      "<cmd>MoveLine(-1)<cr>",   desc = "Move line up" },

    -- Block movement (visual mode)
    { "<M-j>",      "<cmd>MoveBlock(1)<cr>",   mode = "v",                 desc = "Move block down" },
    { "<M-k>",      "<cmd>MoveBlock(-1)<cr>",  mode = "v",                 desc = "Move block up" },
    { "<M-h>",      "<cmd>MoveHBlock(-1)<cr>", mode = "v",                 desc = "Move block left" },
    { "<M-l>",      "<cmd>MoveHBlock(1)<cr>",  mode = "v",                 desc = "Move block right" },

    -- Word movement
    { "<leader>wf", "<cmd>MoveWord(1)<cr>",    desc = "Move word forward" },
    { "<leader>wb", "<cmd>MoveWord(-1)<cr>",   desc = "Move word backward" },

    -- Character movement
    { "<leader>cf", "<cmd>MoveChar(1)<cr>",    desc = "Move char forward" },
    { "<leader>cb", "<cmd>MoveChar(-1)<cr>",   desc = "Move char backward" },
  }
}

