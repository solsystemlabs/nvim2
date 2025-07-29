return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
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
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History (Picker)",
      },
      {
        "<leader>N",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History (Buffer)",
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
      completion = {
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
          },
        },
      },
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
    enabled = false,
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
  {
    "folke/which-key.nvim",
    opts = {
      delay = 300,
      preset = "modern",
      layout = {
        width = { min = 20, max = 40 },
        height = { min = 4, max = 50 },
        spacing = 2,
        align = "center",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "css",
        "diff",
        "dockerfile",
        "gitignore",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "prisma",
        "query",
        "vim",
        "vimdoc",
        "typescript",
        "tsx",
        "vim",
        "yaml",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<bs>",
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
