return {
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       styles = {
  --         comments = { italic = false }, -- Disable italics in comments
  --       },
  --     }
  --
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-storm'
  --   end,
  -- },

  -- {
  --   "tiagovla/tokyodark.nvim",
  --   priority = 1000,
  --   opts = {
  --     -- custom options here
  --     styles = {
  --       comments = { italic = false },
  --       keywords = { italic = false },
  --       identifiers = { italic = false },
  --       functions = { italic = false },
  --       variables = { italic = false },
  --     }
  --   },
  --   config = function(_, opts)
  --     require("tokyodark").setup(opts) -- calling setup is optional
  --     vim.cmd [[colorscheme tokyodark]]
  --   end,
  -- }

  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      -- Lua
      require('onedark').setup {
        -- Main options --
        style = 'deep',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true,           -- Show/hide background
        term_colors = true,           -- Change terminal color as per the selected theme style
        ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'bold,italic',
          strings = 'none',
          variables = 'italic'
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {},     -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true,     -- darker colors for diagnostic
          undercurl = true,  -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }
      require('onedark').load()
      vim.cmd.colorscheme 'onedark'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
