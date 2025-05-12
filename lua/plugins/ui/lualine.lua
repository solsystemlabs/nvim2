return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Custom function to get Jujutsu change ID, commit hash, and description
    -- Cache the result to avoid running external commands repeatedly
    local jj_cache = nil
    local function jj_info()
      -- Return cached info if available
      if jj_cache then
        return jj_cache
      end

      -- Get the jj status output for the working copy
      local jj_status = vim.fn.system("jj st --no-pager 2>/dev/null")

      -- Extract jj change ID and commit hash from status output
      -- Pattern to match lines like "Working copy  (@) : syrvvnly 9c5c890d ..."
      local change_id, commit_hash = jj_status:match("Working copy%s+%(@%)%s+:%s+(%w+)%s+(%w+)")

      if change_id and commit_hash then
        -- Get the description of the current change, using --no-graph to avoid TUI characters
        local jj_desc = vim.fn.system("jj log -r @ --no-graph -T 'description.first_line()'")
        jj_desc = jj_desc:gsub("\n", ""):gsub("^%s+", ""):gsub("%s+$", "")
        if jj_desc == "" then
          jj_desc = "No description"
        end
        jj_cache = change_id .. "  " .. jj_desc .. "  (" .. commit_hash .. ")"
        return jj_cache
      end

      -- Fallback to Git if we're not in a jj repo
      local git_hash = vim.fn.system("git rev-parse --short HEAD 2>/dev/null | tr -d '\n'")
      if git_hash:match("^%w+$") then
        local git_msg = vim.fn.system("git log -1 --pretty=%s 2>/dev/null | tr -d '\n'")
        if git_msg ~= "" then
          jj_cache = git_hash .. "  " .. git_msg
        else
          jj_cache = git_hash
        end
        return jj_cache
      end

      jj_cache = ""
      return "" -- Always return a string, even if empty
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = {
          -- 'branch',
          { jj_info, icon = '' }, -- Our custom function
          'searchcount',
          'diff',
          'diagnostics',
        },
        lualine_c = {},
        lualine_x = { 'selectioncount', 'filesize', 'fileformat', 'filetype', 'lsp_status' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { { jj_info, icon = '' }, 'searchcount', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {
        -- lualine_a = { { 'filename', path = 0 } }
      },
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
