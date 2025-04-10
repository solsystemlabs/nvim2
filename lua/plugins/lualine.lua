return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Custom function to get Jujutsu change ID and commit hash
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
        jj_cache = change_id .. " (" .. commit_hash .. ")"
        return jj_cache
      end

      -- Fallback to Git if we're not in a jj repo
      local git_hash = vim.fn.system("git rev-parse --short HEAD 2>/dev/null | tr -d '\n'")
      if git_hash:match("^%w+$") then
        jj_cache = git_hash
        return jj_cache
      end

      jj_cache = ""
      return "" -- Always return a string, even if empty
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100, -- Refresh every second
          tabline = 100,
          winbar = 100,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          -- 'branch',
          { jj_info, icon = '' }, -- Our custom function
          'searchcount',
          'diff',
          'diagnostics',
        },
        lualine_c = { 'filename' },
        lualine_x = { 'selectioncount', 'filesize', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
