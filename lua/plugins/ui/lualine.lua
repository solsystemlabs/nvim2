return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local jj_cache = nil
    local function jj_info()
      if jj_cache then
        return jj_cache
      end

      local jj_status = vim.fn.system(
        "jj log -r '@' --no-graph -T 'self.change_id().shortest(8) ++ \" \" ++ self.commit_id().shortest(8)'")
      local change_id, commit_hash = jj_status:match("(%w+) (%w+)")

      if change_id and commit_hash then
        jj_cache = change_id .. '  ' .. commit_hash
        return jj_cache
      end

      local git_hash = vim.fn.system("git rev-parse --short HEAD 2>/dev/null | tr -d '\n'")
      if git_hash:match("^%w+$") then
        jj_cache = git_hash
        return jj_cache
      end

      jj_cache = ""

      return ""
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
          {
            function()
              return require("grapple").name_or_index()
            end,
            cond = function()
              return package.loaded["grapple"] and require("grapple").exists()
            end
          },
          'searchcount',
          'diagnostics',
        },
        lualine_c = {},
        lualine_x = { 'selectioncount', 'filesize', 'fileformat', 'filetype', 'lsp_status' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { { jj_info, icon = '' }, 'searchcount', 'diagnostics' },
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
