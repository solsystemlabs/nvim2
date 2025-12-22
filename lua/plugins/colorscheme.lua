return {
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("gruvbox").setup({
  --       invert_tabline = true,
  --       -- contrast = "hard",
  --       transparent_mode = false,
  --     })
  --     require("gruvbox").load()
  --     -- vim.cmd.colorscheme("gruvbox")
  --   end,
  -- },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    lazy = false,
    priority = 1000,
    config = function()
      require("flexoki").setup({
        -- Force floats to use the main dark background instead of ui gray
        float_window_style = "border",
        highlight_groups = {
          -- Snacks popup backgrounds - use main bg instead of lighter gray
          ["SnacksNormal"] = { bg = "#100F0F" },
          ["SnacksNormalNC"] = { bg = "#100F0F" },
          ["SnacksPickerNormal"] = { bg = "#100F0F" },
          ["SnacksPickerBorder"] = { bg = "#100F0F" },
          ["SnacksInputNormal"] = { bg = "#100F0F" },

          -- Search highlights - use dark text on yellow for better contrast
          ["Search"] = { fg = "#100F0F", bg = "#D0A215" },
          ["IncSearch"] = { fg = "#100F0F", bg = "#D0A215" },
          ["CurSearch"] = { fg = "#100F0F", bg = "#AD8301" },
          ["SnacksPickerSearch"] = { fg = "#100F0F", bg = "#D0A215" },
          ["SnacksPickerMatch"] = { fg = "#D0A215", bold = true },

          -- Diff mode highlights (used by diffview.nvim, vimdiff, etc.)
          -- Using subtle backgrounds so text remains readable
          ["DiffAdd"] = { bg = "#1a2a1a" }, -- subtle green tint
          ["DiffDelete"] = { bg = "#2a1a1a" }, -- subtle red tint
          ["DiffChange"] = { bg = "#1a1a2a" }, -- subtle blue tint
          ["DiffText"] = { bg = "#2a2a1a" }, -- subtle yellow tint for changed text

          -- Vim diff syntax (for .diff files and git output)
          ["diffAdded"] = { fg = "#879A39" },
          ["diffRemoved"] = { fg = "#D14D41" },
          ["diffChanged"] = { fg = "#DA702C" },
          ["diffOldFile"] = { fg = "#D14D41", bold = true },
          ["diffNewFile"] = { fg = "#879A39", bold = true },
          ["diffFile"] = { fg = "#4385BE", bold = true },
          ["diffLine"] = { fg = "#8B7EC8" },
          ["diffIndexLine"] = { fg = "#3AA99F" },

          -- Treesitter diff highlights
          ["@diff.plus"] = { fg = "#879A39" },
          ["@diff.minus"] = { fg = "#D14D41" },
          ["@diff.delta"] = { fg = "#DA702C" },
        },
      })
    end,
  },
}
