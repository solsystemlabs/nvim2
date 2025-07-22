return {
  {
    "b0o/incline.nvim",
    config = function()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = "", changed = "", added = "" }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = "", warn = "", info = "", hint = "󰌵" }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
        end,
      })
    end,
  },
  {
    "ya2s/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          enable = true,
          timeout = 0, -- Remove delay
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local jj_cache = nil
      local function jj_info()
        if jj_cache then
          return jj_cache
        end

        local jj_status = vim.fn.system(
          "jj log -r '@' --no-graph -T 'self.change_id().shortest(8) ++ \" \" ++ self.commit_id().shortest(8)'"
        )
        local change_id, commit_hash = jj_status:match("(%w+) (%w+)")

        if change_id and commit_hash then
          jj_cache = change_id .. "  " .. commit_hash
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

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "gruvbox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
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
          },
        },
        sections = {
          lualine_a = { {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          } },
          lualine_b = {
            -- 'branch',
            { jj_info, icon = "" }, -- Our custom function
            {
              function()
                return require("grapple").name_or_index()
              end,
              cond = function()
                return package.loaded["grapple"] and require("grapple").exists()
              end,
            },
            "searchcount",
            "diagnostics",
          },
          lualine_c = {},
          lualine_x = { "selectioncount", "filesize", "fileformat", "filetype", "lsp_status" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = { { jj_info, icon = "" }, "searchcount", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {
          -- lualine_a = { { 'filename', path = 0 } }
        },
        inactive_winbar = {},
        extensions = {},
      })
    end,
  },
}
