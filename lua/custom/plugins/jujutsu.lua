return {
  -- {
  --   dir = "~/jj-grok",
  --   dependencies = { 'powerman/vim-plugin-AnsiEsc' },
  --   config = function()
  --     require('jujutsu').setup()
  --   end
  -- }
  {
    'solsystemlabs/jujutsu.nvim',
    config = function()
      require('jujutsu').setup()
    end,
    dependencies = {
      -- Optional dependencies, if you want to use them
      'powerman/vim-plugin-AnsiEsc'
    }
  }
}
