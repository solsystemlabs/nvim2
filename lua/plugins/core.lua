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
    opts = {
      animate = {
        duration = 20,
        easing = "linear",
        fps = 60,
      },
      explorer = {
        auto_close = true,
        layout = { preset = "sidebar", preview = true },
      },
      indent = { enabled = true },
      input = { enabled = true },
      layout = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 5000,
        top_down = false,
      },
      picker = {
        sources = {
          explorer = {
            auto_close = true,
            layout = { preset = "sidebar", preview = false },
            hidden = true,
            ignored = true,
          },
          files = { hidden = true },
          grep = { hidden = true },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = {
        animate = {
          duration = { step = 10, total = 100 },
          easing = "linear",
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 25 },
          easing = "linear",
        },
        filter = function(buf)
          return vim.g.snacks_scroll ~= false
            and vim.b[buf].snacks_scroll ~= false
            and vim.bo[buf].buftype ~= "terminal"
        end,
      },
    },
    keys = {
      {
        "<leader>fr",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Recent files",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files({ cwd = vim.fn.getcwd() })
        end,
        desc = "Find Git Files",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.recent({ filter = { cwd = true } })
        end,
        desc = "Find Recent Files",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({ cwd = vim.fn.getcwd() })
        end,
        desc = "Grep",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({ cwd = vim.fn.getcwd() })
        end,
        desc = "Word",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = vim.fn.getcwd() })
        end,
        desc = "Explorer",
      },
      {
        "<leader>gg",
        function()
          Snacks.gitui({ cwd = vim.fn.getcwd() })
        end,
        desc = "GitUi",
      },
      { "<leader>fF", false },
      { "<leader>fR", false },
      { "<leader>sG", false },
      { "<leader>sW", false },
      { "<leader>gG", false },
      { "<leader>E", false },
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
