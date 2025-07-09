return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = function(bufnr)
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end

      return { timeout_ms = 1000, lsp_fallback = true }
    end,
    format_after_save = { lsp_fallback = true },
  },
}