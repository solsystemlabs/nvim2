return {
  {
    "rmagatti/auto-session",
    config = function()
      local has_snacks = pcall(function() return _G.Snacks and _G.Snacks.picker end)

      local function close_explorer()
        if has_snacks then
          for _, picker in pairs(Snacks.picker.all or {}) do
            if picker.source and picker.source.name == "explorer" then
              picker:close()
            end
          end
        end
      end

      local function open_explorer()
        if has_snacks then
          local found = false
          for _, picker in pairs(Snacks.picker.all or {}) do
            if picker.source and picker.source.name == "explorer" then
              found = true
              break
            end
          end

          if not found then
            vim.schedule(function()
              Snacks.explorer()
            end)
          end
        end
      end

      require("auto-session").setup {
        log_level = "error",
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_save = true,
        auto_restore = true,
        auto_session_use_git_branch = true,
        auto_session_on_exit = true,
        pre_save_cmds = { close_explorer },
      }

      -- Add keymaps for session management
      vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session,
        { desc = "[S]ession [S]earch" })
      vim.keymap.set("n", "<leader>sd", ":Autosession delete<CR>",
        { desc = "[S]ession [D]elete" })
    end,
  }
}
