return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      debug = false,

      sources = {
        -- Focus on sources not covered by your existing setup

        -- Code Actions (not provided by LSP servers)
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,

        -- Diagnostics for languages not already covered
        null_ls.builtins.diagnostics.hadolint, -- Dockerfile linting

        -- Specialized formatters for languages not in conform.nvim
        -- (Note: avoid adding formatters for HTML, CSS, JS, TS, etc.)

        -- Completion sources
        null_ls.builtins.completion.spell, -- Spell checking completion
      },
    })
  end,
}
