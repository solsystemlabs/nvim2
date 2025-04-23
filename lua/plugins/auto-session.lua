return {
  {
    "rmagatti/auto-session",
    config = function()
      -- Check if Snacks.picker is available (indicating Snacks.nvim is installed)
      local has_snacks = pcall(function() return _G.Snacks and _G.Snacks.picker end)

      local function close_explorer()
        if has_snacks then
          -- Get all pickers and close any explorer pickers
          for _, picker in pairs(Snacks.picker.all or {}) do
            if picker.source and picker.source.name == "explorer" then
              picker:close()
            end
          end
        end
      end

      local function open_explorer()
        if has_snacks then
          -- Only open explorer if not already open
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
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = true,
        -- Save session when leaving Neovim
        auto_session_on_exit = true,
        -- Close Snacks explorer before saving session
        pre_save_cmds = { close_explorer },
        -- Open Snacks explorer after restoring session
        -- post_restore_cmds = { open_explorer }
      }

      -- Add keymaps for session management
      vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session,
        { desc = "[S]ession [S]earch" })
      vim.keymap.set("n", "<leader>sd", ":Autosession delete<CR>",
        { desc = "[S]ession [D]elete" })
    end,
  }
}
