return {
  -- {
  --   'jujutsu',
  --   dir = '~/jj-gemini',
  --   lazy = false,
  --   dev = true,
  --   keys = {
  --     -- Log
  --     { "<leader>jl", "<Cmd>JjLog<CR>",      desc = "[J]ujutsu [L]og" },
  --     -- Edit (prompts)
  --     { "<leader>je", "<Cmd>JjEdit<CR>",     desc = "[J]ujutsu [E]dit Revision" },
  --     -- Describe (prompts for @)
  --     { "<leader>jd", "<Cmd>JjDescribe<CR>", desc = "[J]ujutsu [D]escribe @" },
  --     -- New (prompts based on @)
  --     { "<leader>jn", "<Cmd>JjNew<CR>",      desc = "[J]ujutsu [N]ew Change" },
  --     -- Next / Previous
  --     { "<leader>jN", "<Cmd>JjNext<CR>",     desc = "[J]ujutsu [N]ext Change" }, -- Note capital N
  --     { "<leader>jp", "<Cmd>JjPrev<CR>",     desc = "[J]ujutsu [P]revious Change" },
  --
  --     -- Optional: You could add more specific binds, e.g., describe specific revision
  --     -- { "<leader>jd", function() vim.ui.input({prompt = "Describe Revision: "}, function(rev) if rev then vim.cmd("JjDescribe "..rev) end end) end, desc = "[J]ujutsu [D]escribe..." },
  --   },
  --   config = function()
  --     require('jujutsu').setup()
  --   end
  -- },
  {
    dir = '~/jujutsu-me.nvim',
    config = function()
      require('jujutsu').setup()
    end
  }
  -- {
  --   'solsystemlabs/jujutsu.nvim',
  --   config = function()
  --     require('jujutsu').setup()
  --   end,
  --   dependencies = {
  --     -- Optional dependencies, if you want to use them
  --   }
  -- }
}
