return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        invert_tabline = true,
        -- contrast = "hard",
        transparent_mode = false,
      })
      require("gruvbox").load()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
