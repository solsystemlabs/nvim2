return { {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    animate = {
      duration = 20,
      easing = 'linear',
      fps = 60,
    },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
      auto_close = true,
      layout = { preset = "sidebar", preview = true },
    },
    indent = { enabled = true },
    input = { enabled = true },
    layout = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          layout = { preset = "sidebar", preview = false },
          hidden = true,
        },
      }
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
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
      end
    },
    statuscolumn = {
      left = { "mark", "sign" }, -- priority of signs on the left (high to low)
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = true,             -- show open fold icons
        git_hl = true,           -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    terminal = { enabled = true },
    win = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader>.",       function() Snacks.picker.smart() end,                                    desc = "Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,                                  desc = "Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                                     desc = "Grep" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                          desc = "Command History" },
    { "<leader><space>", function() require('telescope.builtin').oldfiles() end,                  desc = "Search Recent Files" },
    { "<leader>e",       function() Snacks.explorer() end,                                        desc = "File Explorer" },
    { "<leader>n",       function() Snacks.picker.notifications() end,                            desc = "Notification History" },

    -- Augment
    { "<leader>ac",      function() vim.cmd("Augment chat") end,                                  desc = "Chat" },
    { "<leader>ad",      function() vim.cmd("Augment disable") end,                               desc = "Disable" },
    { "<leader>ae",      function() vim.cmd("Augment enable") end,                                desc = "Enable" },
    { "<leader>al",      function() vim.cmd("Augment log") end,                                   desc = "Log" },
    { "<leader>an",      function() vim.cmd("Augment chat-new") end,                              desc = "New Chat" },
    { "<leader>as",      function() vim.cmd("Augment status") end,                                desc = "Status" },
    { "<leader>at",      function() vim.cmd("Augment chat-toggle") end,                           desc = "Toggle Chat Window" },

    { "<leader>bc",      function() Snacks.bufdelete() end,                                       desc = "Close current buffer" },
    { "<leader>bC",      function() Snacks.bufdelete({ force = true }) end,                       desc = "Force close current buffer" },
    { "<leader>bo",      function() require('buffers').close_all_buffers_except_current() end,    desc = "Close all buffers except current" },
    { "<leader>ba",      function() require('buffers').close_all_buffers() end,                   desc = "Close all buffers" },
    { "<leader>bu",      function() require('buffers').close_unmodified_buffers() end,            desc = "Close unmodified buffers" },
    { "<leader>bl",      function() require('buffers').close_buffers_to_left() end,               desc = "Close buffers to the left" },
    { "<leader>br",      function() require('buffers').close_buffers_to_right() end,              desc = "Close buffers to the right" },
    { "<leader>bm",      function() require('buffers').list_modified_buffers() end,               desc = "List modified buffers" },
    { "<leader>bs",      function() Snacks.picker.buffers() end,                                  desc = "Buffer selector" },

    -- Quick buffer navigation (additional to what you might already have)
    { "[b",              function() vim.cmd("bprevious") end,                                     desc = "Previous buffer" },
    { "]b",              function() vim.cmd("bnext") end,                                         desc = "Next buffer" },
    { "<leader>bn",      function() vim.cmd("bnext") end,                                         desc = "Next buffer" },
    { "<leader>bp",      function() vim.cmd("bprevious") end,                                     desc = "Previous buffer" },
    { "<leader>b1",      function() vim.cmd("buffer 1") end,                                      desc = "Buffer 1" },
    { "<leader>b2",      function() vim.cmd("buffer 2") end,                                      desc = "Buffer 2" },
    { "<leader>b3",      function() vim.cmd("buffer 3") end,                                      desc = "Buffer 3" },
    { "<leader>b4",      function() vim.cmd("buffer 4") end,                                      desc = "Buffer 4" },
    { "<leader>b5",      function() vim.cmd("buffer 5") end,                                      desc = "Buffer 5" },

    { "<leader>cc",      function() vim.cmd('source $MYVIMRC') end,                               desc = "Source neovim" },

    -- find
    { "<leader>fb",      function() Snacks.picker.buffers() end,                                  desc = "Buffers" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,  desc = "Find Config File" },
    { "<leader>ff",      function() Snacks.picker.files() end,                                    desc = "Find Files" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,                                desc = "Find Git Files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,                                 desc = "Projects" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                   desc = "Recent" },

    -- git
    { "<leader>gb",      function() Snacks.picker.git_branches() end,                             desc = "Git Branches" },
    { "<leader>gc",      function() require("telescope-extensions").find_branch_only_files() end, desc = "Git Changed Files" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                                 desc = "Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,                             desc = "Git Log File" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,                                  desc = "Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,                             desc = "Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                               desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                                desc = "Git Stash" },

    -- dadbod-explorer
    { "<leader>le",      function() require("dadbod-explorer").explore() end,                     desc = "Explore" },
    { "<leader>ld",      function() require("dadbod-explorer").action("describe") end,            desc = "Describe" },
    { "<leader>ls",      function() require("dadbod-explorer").action("show_sample") end,         desc = "Show Sample" },
    { "<leader>lw",      function() require("dadbod-explorer").action("show_filter") end,         desc = "Show Filter" },
    { "<leader>lv",      function() require("dadbod-explorer").action("show_distribution") end,   desc = "Show Distribution" },
    { "<leader>ly",      function() require("dadbod-explorer").action("yank_columns") end,        desc = "Yank Columns" },
    { "<leader>lo",      function() require("dadbod-explorer").action("list_objects") end,        desc = "List Objects" },

    -- Grep
    { "<leader>sg",      function() Snacks.picker.grep() end,                                     desc = "Grep" },
    { "<leader>sO",      function() Snacks.picker.grep_buffers() end,                             desc = "Grep Open Buffers" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,                                desc = "Visual selection or word",        mode = { "n", "x" } },

    -- search
    { '<leader>s"',      function() Snacks.picker.registers() end,                                desc = "Registers" },
    { '<leader>s/',      function() Snacks.picker.search_history() end,                           desc = "Search History" },
    { "<leader>sa",      function() Snacks.picker.autocmds() end,                                 desc = "Autocmds" },
    { "<leader>sb",      function() require("telescope-extensions").find_branch_only_files() end, desc = "Find Branch Files" },
    { "<leader>sc",      function() Snacks.picker.command_history() end,                          desc = "Command History" },
    { "<leader>sC",      function() Snacks.picker.commands() end,                                 desc = "Commands" },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                              desc = "Diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                       desc = "Buffer Diagnostics" },
    { "<leader>se",      function() Snacks.picker.lsp_symbols() end,                              desc = "LSP Symbols" },
    { "<leader>sh",      function() Snacks.picker.help() end,                                     desc = "Help Pages" },
    { "<leader>sH",      function() Snacks.picker.highlights() end,                               desc = "Highlights" },
    { "<leader>si",      function() Snacks.picker.icons() end,                                    desc = "Icons" },
    { "<leader>sj",      function() Snacks.picker.jumps() end,                                    desc = "Jumps" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,                                  desc = "Keymaps" },
    { "<leader>sl",      function() Snacks.picker.lines() end,                                    desc = "Buffer Lines" },
    { "<leader>sL",      function() Snacks.picker.loclist() end,                                  desc = "Location List" },
    { "<leader>sm",      function() require("telescope.builtin").git_status() end,                desc = "Modified" },
    { "<leader>sM",      function() Snacks.picker.man() end,                                      desc = "Man Pages" },
    { "<leader>sp",      function() Snacks.picker.lazy() end,                                     desc = "Search for Plugin Spec" },
    { "<leader>sq",      function() Snacks.picker.qflist() end,                                   desc = "Quickfix List" },
    { "<leader>sR",      function() Snacks.picker.resume() end,                                   desc = "Resume" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                    desc = "LSP Workspace Symbols" },
    { "<leader>su",      function() require('modified-buffers')() end,                            desc = "Unsaved buffers with diff" },

    -- LSP
    { "gd",              function() Snacks.picker.lsp_definitions() end,                          desc = "Goto Definition" },
    { "gD",              function() Snacks.picker.lsp_declarations() end,                         desc = "Goto Declaration" },
    { "gI",              function() Snacks.picker.lsp_implementations() end,                      desc = "Goto Implementation" },
    { "gr",              function() Snacks.picker.lsp_references() end,                           nowait = true,                            desc = "References" },
    { "gy",              function() Snacks.picker.lsp_type_definitions() end,                     desc = "Goto T[y]pe Definition" },

    -- Other
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                         desc = "Prev Reference",                  mode = { "n", "t" } },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,                          desc = "Next Reference",                  mode = { "n", "t" } },
    { "<c-/>",           function() Snacks.terminal() end,                                        desc = "Toggle Terminal" },
    { "<c-_>",           function() Snacks.terminal() end,                                        desc = "which_key_ignore" },
    { "<leader>;",       function() Snacks.scratch() end,                                         desc = "Toggle Scratch Buffer" },
    { "<leader>bd",      function() Snacks.bufdelete() end,                                       desc = "Delete Buffer" },
    { "<leader>cR",      function() Snacks.rename.rename_file() end,                              desc = "Rename File" },
    { "<leader>gB",      function() Snacks.gitbrowse() end,                                       desc = "Git Browse",                      mode = { "n", "v" } },
    { "<leader>gg",      function() Snacks.lazygit() end,                                         desc = "Lazygit" },
    { "<leader>n",       function() Snacks.notifier.show_history() end,                           desc = "Notification History" },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file =
              vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 }
        })
      end
    },
    { "<leader>S",  function() Snacks.scratch.select() end,      desc = "Select Scratch Buffer" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>un", function() Snacks.notifier.hide() end,       desc = "Dismiss All Notifications" },
    { "<leader>z",  function() Snacks.zen() end,                 desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end,            desc = "Toggle Zoom" },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
        Snacks.toggle({
          name = 'Undotree',
          set = function()
            vim.cmd.UndotreeToggle()
          end
        }):map("<leader>uu")
      end,
    })
  end,
} }
