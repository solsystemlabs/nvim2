return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      news = {
        neovim = true,
      },
    },
  },
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>fr",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent files",
      },
      {
        "<leader>fR",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent files (global)",
      },
    },
  },
}
