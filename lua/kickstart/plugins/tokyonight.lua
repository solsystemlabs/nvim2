return {
  {                  -- You can easily change to a different colorscheme.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
        transparent = true,              -- Add this line to enable transparency
      }

      -- Load the colorscheme here.
      vim.cmd.colorscheme 'tokyonight-moon'

      -- transparency control - these should still be here to override any remaining settings
      -- Set background to none for regular text in active windows
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
      -- Set background to none for special characters and whitespace
      vim.api.nvim_set_hl(0, 'NonText', { bg = 'NONE' })
      -- Set background to none for non-current (inactive) windows
      vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
      -- Additional highlight groups that might need transparency
      vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE' })
    end,
  },
}

