return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("grapple").setup({
      scope = "git", -- Use git as the scope for tagging
      icons = true,  -- Enable icons if you have a nerd font
      status = true, -- Show grapple status in lualine or statusline
    })
  end,
}
