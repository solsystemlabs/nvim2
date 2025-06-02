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
  -- {
  --   dir = '~/jj',
  --   config = function()
  --     require('jj').setup()
  --   end,
  -- },
  -- {
  --   'solsystemlabs/jj-rust',
  --   build = 'cd rust && cargo build --release && ./setup.sh',
  --   config = function()
  --     require('jj').setup()
  --   end,
  --   keys = { { '<leader>jh', desc = "jj rust" } },
  --   cmd = { "JjLog" },
  -- },
}
