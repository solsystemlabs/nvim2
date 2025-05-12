return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = 'powerline',
        hi = {
          arrow = 'DiagnosticInfo',
        },
        options = {
          show_source = {
            if_many = true,
          },
          multilines = {
            enabled = true,
            always_show = true,
          },
          enable_on_insert = true,
          set_arrow_to_diag_color = true,
          throttle = 10,
          format = function(diagnostic)
            return " [" .. diagnostic.source .. "] " .. diagnostic.message
          end
        },
      })
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  }
}
