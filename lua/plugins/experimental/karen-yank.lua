return {
  {
    'tenxsoydev/karen-yank.nvim',
    event = 'TextYankPost',
    config = function()
      require('karen-yank').setup()
    end,
  },
}
