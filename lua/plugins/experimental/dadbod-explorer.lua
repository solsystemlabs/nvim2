return {
  {
    'tkopets/dadbod-explorer.nvim',
    dependencies = {
      'tpope/vim-dadbod',
      -- Optional: For enhanced UI.  Choose ONE of the following:
      -- 'fzf-lua/fzf-lua',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    -- ft = { "sql" }, -- Optional: enable only for SQL files
    config = function()
      require('dadbod-explorer').setup()
    end
  }
}
