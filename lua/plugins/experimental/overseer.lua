return {
  {
    'stevearc/overseer.nvim',
    opts = {
      -- Configuration options for overseer.nvim
      strategy = 'terminal', -- Use terminal strategy by default
      close_on_exit = false, -- Keep the terminal open after task completion
      -- Add more configuration as needed
    },
    config = function(_, opts)
      require('overseer').setup(opts)
      -- Add any additional setup or keybindings here if needed
    end,
  },
}
