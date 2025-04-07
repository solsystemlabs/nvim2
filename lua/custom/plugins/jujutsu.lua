return {
  {
    'solsystemlabs/jujutsu.nvim',
    branch = 'add-color-to-log',
    config = function()
      require('jujutsu').setup()
    end,
    dependencies = {
      -- Optional dependencies, if you want to use them
    }
  }
}
