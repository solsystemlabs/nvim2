return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MisanthropicBit/neotest-busted",
    },
    opts = {
      adapters = {
        ["neotest-busted"] = {
          busted_args = { "--shuffle-files" },
          parametric_test_discovery = true,
        },
      },
    },
  },
  -- {
  --   "stevearc/overseer.nvim",
  --   cmd = {
  --     "OverseerToggle",
  --     "OverseerRun",
  --     "OverseerQuickAction",
  --     "OverseerTaskAction",
  --     "OverseerBuild",
  --     "OverseerRunCmd",
  --     "OverseerInfo",
  --   },
  --   keys = {
  --     -- Task management keybinds under <leader>T (uppercase T to avoid conflict with neotest)
  --     { "<leader>TT", "<cmd>OverseerToggle<cr>",      desc = "Toggle Overseer" },
  --     { "<leader>Tr", "<cmd>OverseerRun<cr>",         desc = "Run Task" },
  --     { "<leader>Tq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
  --     { "<leader>Ta", "<cmd>OverseerTaskAction<cr>",  desc = "Task Action" },
  --     { "<leader>Tb", "<cmd>OverseerBuild<cr>",       desc = "Build" },
  --     { "<leader>Ti", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
  --     
  --     -- Disable LazyVim's default overseer keybinds to prevent conflicts with Obsidian
  --     { "<leader>ow", false },
  --     { "<leader>oo", false },
  --     { "<leader>oq", false },
  --     { "<leader>oi", false },
  --     { "<leader>ob", false },
  --     { "<leader>ot", false },
  --     { "<leader>oc", false },
  --   },
  --   opts = {
  --     strategy = {
  --       "terminal",
  --       auto_scroll = true,
  --       use_shell = false,
  --       quit_on_exit = "never",
  --     },
  --     templates = { "builtin", "user.pnpm_lint" },
  --     task_list = {
  --       direction = "bottom",
  --       min_height = 25,
  --       max_height = 25,
  --       default_detail = 1,
  --     },
  --     form = {
  --       border = "rounded",
  --       win_opts = {
  --         winblend = 0,
  --       },
  --     },
  --     task_win = {
  --       border = "rounded",
  --       win_opts = {
  --         winblend = 0,
  --       },
  --     },
  --     component_aliases = {
  --       default = {
  --         { "display_duration", detail_level = 2 },
  --         "on_output_summarize",
  --         "on_exit_set_status",
  --         { "on_complete_notify", system = "unfocused" },
  --         "on_complete_dispose",
  --       },
  --       default_neotest = {
  --         "unique",
  --         "on_output_summarize",
  --         "on_exit_set_status",
  --         { "on_complete_notify", system = "unfocused" },
  --         "on_complete_dispose",
  --       },
  --     },
  --   },
  -- },
}
