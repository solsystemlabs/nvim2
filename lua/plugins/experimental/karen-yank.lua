return {
  {
    '2kabhishek/karen-yank.nvim',
    event = 'TextYankPost',
    config = function()
      require('karen-yank').setup({
        -- Configuration options for karen-yank
        highlight = {
          enable = true,
          timeout = 500, -- Duration of highlight in milliseconds
        },
      })
    end,
  },
}
