return {
  -- {
  --   'solsystemlabs/jujutsu.nvim',
  --   branch = 'master',
  --   config = function()
  --     require('jujutsu').setup()
  --   end,
  -- },
  {
    dir = "~/jj-grok",
    config = function()
      require('jujutsu').setup()
    end
  },
  {
    dir = '~/projects/jj-nvim/',
    config = function()
      require('jj-nvim').setup({
        window = {
          width = 70,
          position = 'right',
          wrap = true, -- Re-enabled until we fix smart wrapping
          border = {
            enabled = true,
            style = 'left',   -- 'none', 'single', 'double', 'rounded', 'thick', 'shadow', 'left'
            color = 'accent', -- 'gray', 'subtle', 'accent', 'muted' or hex color like '#555555'
          },
        },
        keymaps = {
          toggle = '<leader>ji',
          close = 'q',
          show_diff = '<CR>',
          edit_message = 'e',
          abandon = 'a',
          rebase = 'r',
          next_commit = 'j',
          prev_commit = 'k',
        },
        log = {
          format = 'short',
          limit = 100,
        },
        colors = {
          theme = 'auto', -- 'auto', 'gruvbox', 'catppuccin', 'nord', 'tokyo-night', 'onedark', 'default'
        },
        diff = {
          format = 'stat',      -- 'git', 'stat', 'color-words', 'name-only'
          display = 'float',    -- 'split', 'float'
          split = 'horizontal', -- 'horizontal', 'vertical' (for split mode)
          size = 50,            -- Size percentage for diff window
          float = {
            width = 0.8,        -- Floating window width as percentage of screen
            height = 0.8,       -- Floating window height as percentage of screen
            border = 'rounded', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
          },
        },
        status = {
          display = 'float',    -- 'split', 'float'
          split = 'horizontal', -- 'horizontal', 'vertical' (for split mode)
          size = 50,            -- Size percentage for status window
          float = {
            width = 0.8,        -- Floating window width as percentage of screen
            height = 0.8,       -- Floating window height as percentage of screen
            border = 'rounded', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow'
          },
        }
      })
    end,
  },
}
