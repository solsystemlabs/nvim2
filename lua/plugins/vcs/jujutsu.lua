return {
  -- {
  --   'solsystemlabs/jujutsu.nvim',
  --   branch = 'develop',
  --   dependencies = { 'powerman/vim-plugin-AnsiEsc' },
  --   config = function()
  --     require('jujutsu').setup()
  --   end,
  -- }
  {
    dir = "~/jj-grok",
    dependencies = { 'powerman/vim-plugin-AnsiEsc' },
    config = function()
      require('jujutsu').setup()
    end
  }
}
