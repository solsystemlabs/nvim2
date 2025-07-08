return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      news = {
        neovim = true,
      },
    },
  },
  {
    "snacks.nvim",
    keys = {
      {
        "<leader>fr",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent files",
      },
      {
        "<leader>fR",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent files (global)",
      },
      -- Override default file search commands to always use cwd
      {
        "<leader>ff",
        function()
          Snacks.picker.files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find Files (cwd)",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find Git Files (cwd)",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Find Recent Files (cwd)",
      },
      -- Swap search functionality: sg -> cwd, sG -> root
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({ cwd = vim.fn.getcwd() })
        end,
        desc = "Grep (cwd)",
      },
      {
        "<leader>sG",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep (Root Dir)",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({ cwd = vim.fn.getcwd() })
        end,
        desc = "Word (cwd)",
      },
      {
        "<leader>sW",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Word (Root Dir)",
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
          if package.loaded.edgy then
            local old_offset = get()
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
              if sb and #sb.wins > 0 then
                ret[pos] = old_offset[pos .. "_size"] > 0 and old_offset[pos]
                  or pos == "left" and ("%#Bold#" .. title .. "%*" .. "%#BufferLineOffsetSeparator#│%*")
                  or pos == "right" and ("%#BufferLineOffsetSeparator#│%*" .. "%#Bold#" .. title .. "%*")
                ret[pos .. "_size"] = old_offset[pos .. "_size"] > 0 and old_offset[pos .. "_size"] or sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
    end,
  },
}
