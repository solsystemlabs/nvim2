return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("grapple").setup({
      scope = "git", -- Use git as the scope for tagging
      icons = true,  -- Enable icons if you have a nerd font
      status = true, -- Show grapple status in lualine or statusline
    })

    -- Keymaps for Grapple
    local map = vim.keymap.set
    map("n", "<leader>m", require("grapple").toggle, { desc = "Toggle file tag (Grapple)" })
    map("n", "<leader>M", require("grapple").toggle_tags, { desc = "Manage tags (Grapple)" })
    map("n", "<leader>1", function() require("grapple").select({ key = 1 }) end, { desc = "Go to tag 1 (Grapple)" })
    map("n", "<leader>2", function() require("grapple").select({ key = 2 }) end, { desc = "Go to tag 2 (Grapple)" })
    map("n", "<leader>3", function() require("grapple").select({ key = 3 }) end, { desc = "Go to tag 3 (Grapple)" })
    map("n", "<leader>4", function() require("grapple").select({ key = 4 }) end, { desc = "Go to tag 4 (Grapple)" })
    map("n", "<leader>5", function() require("grapple").select({ key = 5 }) end, { desc = "Go to tag 5 (Grapple)" })
  end,
}
