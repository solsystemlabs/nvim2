return {
  -- {
  --   'solsystemlabs/jujutsu.nvim',
  --   dependencies = { 'powerman/vim-plugin-AnsiEsc' },
  --   config = function()
  --     require('jujutsu').setup()
  --   end,
  -- }
  {
    'solsystemlabs/jujutsu.nvim',
    branch = 'develop',
    dependencies = { 'powerman/vim-plugin-AnsiEsc' },
    config = function()
      require('jujutsu').setup()
    end,
  }
}
