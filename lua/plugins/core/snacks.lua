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
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
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
    { "<leader>.",       function() Snacks.picker.smart() end,                                            desc = "Smart Find Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,                                          desc = "Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                                             desc = "Grep" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                                  desc = "Command History" },
    { "<leader><space>", function() Snacks.picker.recent({ hidden = true, filter = { cwd = true } }) end, desc = "Search Recent Files" },
    { "<leader>e",       function() Snacks.explorer() end,                                                desc = "File Explorer" },
    { "<leader>n",       function() Snacks.picker.notifications() end,                                    desc = "Notification History" },

    { "<leader>ca",      function() require("actions-preview").code_actions() end,                        desc = "Actions Preview" },
    { "<leader>cc",      function() vim.cmd('source $MYVIMRC') end,                                       desc = "Source neovim" },
    { "<leader>cR",      function() Snacks.rename.rename_file() end,                                      desc = "Rename File" },

    { "<leader>a",       function() vim.cmd('normal! ggVG') end,                                          desc = 'Select All' },

    -- nvim-scissors
    { "<leader>pa",      function() require("scissors").addNewSnippet() end,                              desc = "Add Snippet" },
    { "<leader>pe",      function() require("scissors").editSnippet() end,                                desc = "Edit Snippet" },

    -- find
    { "<leader>fb",      function() Snacks.picker.buffers() end,                                          desc = "Buffers" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,          desc = "Find Config File" },
    { "<leader>ff",      function() Snacks.picker.files() end,                                            desc = "Find Files" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,                                        desc = "Find Git Files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,                                         desc = "Projects" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                           desc = "Recent" },

    -- git
    { "<leader>gB",      function() Snacks.gitbrowse() end,                                               desc = "Git Browse",          mode = { "n", "v" } },
    { "<leader>gb",      function() Snacks.picker.git_branches() end,                                     desc = "Git Branches" },
    { "<leader>gc",      function() require("telescope-extensions").find_branch_only_files() end,         desc = "Git Changed Files" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                                         desc = "Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,                                     desc = "Git Log File" },
    { "<leader>gg",      function() Snacks.lazygit() end,                                                 desc = "Lazygit" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,                                          desc = "Git Log" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,                                     desc = "Git Log Line" },
    { "<leader>gm",      function() vim.cmd("BlameToggle window") end,                                    desc = "Git Blame (Window)" },
    { "<leader>gv",      function() vim.cmd("BlameToggle virtual") end,                                   desc = "Git Blame (Virtual)" },
    { "<leader>gp",      function() Snacks.picker.git_grep() end,                                         desc = "Git Grep" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                                       desc = "Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_grep({ need_search = true }) end,                   desc = "Git Search" },
    { "<leader>gu",      function() Snacks.picker.git_grep({ untracked = true }) end,                     desc = "Git Grep (untracked)" },

    -- dadbod-explorer
    { "<leader>de",      function() require("dadbod-explorer").explore() end,                             desc = "Explore" },
    { "<leader>dd",      function() require("dadbod-explorer").action("describe") end,                    desc = "Describe" },
    { "<leader>ds",      function() require("dadbod-explorer").action("show_sample") end,                 desc = "Show Sample" },
    { "<leader>dw",      function() require("dadbod-explorer").action("show_filter") end,                 desc = "Show Filter" },
    { "<leader>dv",      function() require("dadbod-explorer").action("show_distribution") end,           desc = "Show Distribution" },
    { "<leader>dy",      function() require("dadbod-explorer").action("yank_columns") end,                desc = "Yank Columns" },
    { "<leader>do",      function() require("dadbod-explorer").action("list_objects") end,                desc = "List Objects" },

    -- =====================================================
    -- GRUG-FAR SEARCH AND REPLACE KEYBINDINGS
    -- =====================================================

    -- BASIC FIND AND REPLACE
    -- <leader>r prefix for replace operations (avoiding conflicts with existing <leader>s* search)
    {
      '<leader>rr',
      function()
        local grug = require('grug-far')
        local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
          },
        })
      end,
      mode = { 'n', 'v' },
      desc = '[R]eplace in project'
    },
    {
      '<leader>rw',
      function()
        require('grug-far').open({
          prefills = { search = vim.fn.expand('<cword>') }
        })
      end,
      desc = '[R]eplace current [W]ord'
    },
    {
      '<leader>rf',
      function()
        require('grug-far').open({
          prefills = {
            paths = vim.fn.expand('%'),
            search = vim.fn.expand('<cword>')
          }
        })
      end,
      desc = '[R]eplace in current [F]ile'
    },
    {
      '<leader>rs',
      function()
        local search = vim.fn.getreg('/')
        -- Handle word boundaries for * searches
        if search and vim.startswith(search, '\\<') and vim.endswith(search, '\\>') then
          search = '\\b' .. search:sub(3, -3) .. '\\b'
        end
        require('grug-far').open({
          prefills = { search = search },
        })
      end,
      mode = { 'n', 'x' },
      desc = '[R]eplace using last [S]earch'
    },
    {
      '<leader>rv',
      function()
        require('grug-far').open({
          visualSelectionUsage = 'operate-within-range'
        })
      end,
      mode = { 'n', 'x' },
      desc = '[R]eplace within [V]isual range'
    },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end,                                desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end,                           desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end,                                 desc = "Autocmds" },
    { "<leader>sb", function() require("telescope-extensions").find_branch_only_files() end, desc = "Find Branch Files" },
    { "<leader>sc", function() Snacks.picker.command_history() end,                          desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end,                                 desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end,                              desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                       desc = "Buffer Diagnostics" },
    { "<leader>se", function() Snacks.picker.lsp_symbols() end,                              desc = "LSP Symbols" },
    { "<leader>sg", function() Snacks.picker.grep() end,                                     desc = "Grep" },
    { "<leader>sh", function() Snacks.picker.help() end,                                     desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end,                               desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end,                                    desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end,                                    desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end,                                  desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.lines() end,                                    desc = "Buffer Lines" },
    { "<leader>sL", function() Snacks.picker.loclist() end,                                  desc = "Location List" },
    { "<leader>sm", function() require("telescope.builtin").git_status() end,                desc = "Modified" },
    { "<leader>sM", function() Snacks.picker.man() end,                                      desc = "Man Pages" },
    { "<leader>sO", function() Snacks.picker.grep_buffers() end,                             desc = "Grep Open Buffers" },
    { "<leader>sp", function() Snacks.picker.lazy() end,                                     desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end,                                   desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end,                                   desc = "Resume" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                    desc = "LSP Workspace Symbols" },
    { "<leader>su", function() require('modified-buffers')() end,                            desc = "Unsaved buffers with diff" },
    { "<leader>sw", function() Snacks.picker.grep_word() end,                                desc = "Visual selection or word", mode = { "n", "x" } },

    -- LSP
    { "gd",         function() Snacks.picker.lsp_definitions() end,                          desc = "Goto Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end,                         desc = "Goto Declaration" },
    { "gI",         function() Snacks.picker.lsp_implementations() end,                      desc = "Goto Implementation" },
    { "gr",         function() Snacks.picker.lsp_references() end,                           nowait = true,                     desc = "References" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end,                     desc = "Goto T[y]pe Definition" },

    -- Other
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                         desc = "Prev Reference",           mode = { "n", "t" } },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,                          desc = "Next Reference",           mode = { "n", "t" } },
    { "<c-/>",      function() Snacks.terminal() end,                                        desc = "Toggle Terminal" },
    { "<leader>;",  function() Snacks.scratch() end,                                         desc = "Toggle Scratch Buffer" },
    { "<leader>n",  function() Snacks.notifier.show_history() end,                           desc = "Notification History" },
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
    },
    -- Overseer keymaps
    { "<leader>tt", function() vim.cmd("OverseerToggle") end,       desc = "Toggle Overseer" },
    { "<leader>tr", function() vim.cmd("OverseerRun") end,          desc = "Run Task" },
    { "<leader>tq", function() vim.cmd("OverseerQuickAction") end,  desc = "Quick Action" },
    { "<leader>ta", function() vim.cmd("OverseerTaskAction") end,   desc = "Task Action" },
    { "<leader>tb", function() vim.cmd("OverseerBuild") end,        desc = "Build" },

    -- TSC keymaps
    { "<leader>tc", function() vim.cmd("TSC") end,                  desc = "TypeScript Check" },

    -- Grapple keymaps
    { "<leader>M", function() require("grapple").toggle() end,              desc = "Toggle file tag (Grapple)" },
    { "<leader>1", function() require("grapple").select({ index = 1 }) end, desc = "Go to tag 1 (Grapple)" },
    { "<leader>2", function() require("grapple").select({ index = 2 }) end, desc = "Go to tag 2 (Grapple)" },
    { "<leader>3", function() require("grapple").select({ index = 3 }) end, desc = "Go to tag 3 (Grapple)" },
    { "<leader>4", function() require("grapple").select({ index = 4 }) end, desc = "Go to tag 4 (Grapple)" },
    { "<leader>5", function() require("grapple").select({ index = 5 }) end, desc = "Go to tag 5 (Grapple)" },

    -- Precognition keymaps
    { "<leader>up", function() require("precognition").toggle() end, desc = "Toggle Precognition" },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
      pattern = { 'grug-far' },
      callback = function()
        local opts = { buffer = true }

        -- NAVIGATION KEYBINDINGS
        -- Open location and close grug-far
        vim.keymap.set('n', '<C-CR>', function()
          local inst = require('grug-far').get_instance(0)
          inst:open_location()
          inst:close()
        end, vim.tbl_extend('force', opts, { desc = 'Open location and close' }))

        -- Open location but keep grug-far open
        vim.keymap.set('n', '<CR>', function()
          require('grug-far').get_instance(0):open_location()
        end, vim.tbl_extend('force', opts, { desc = 'Open location' }))

        -- REPLACE OPERATIONS (using localleader as recommended)
        -- Note: These are the default grug-far keybindings, included for reference
        -- <localleader>r - Replace all
        -- <localleader>j - Replace current and go to next
        -- <localleader>k - Replace current and go to previous
        -- <localleader>q - Add results to quickfix list

        -- CUSTOM ADDITIONAL KEYBINDINGS
        -- Toggle word boundaries (fixed strings)
        vim.keymap.set('n', '<localleader>w', function()
          local state = unpack(require('grug-far').get_instance(0):toggle_flags({ '--fixed-strings' }))
          vim.notify('grug-far: toggled --fixed-strings ' .. (state and 'ON' or 'OFF'))
        end, vim.tbl_extend('force', opts, { desc = 'Toggle word boundaries' }))

        -- Toggle case sensitivity
        vim.keymap.set('n', '<localleader>c', function()
          local state = unpack(require('grug-far').get_instance(0):toggle_flags({ '--ignore-case' }))
          vim.notify('grug-far: toggled --ignore-case ' .. (state and 'ON' or 'OFF'))
        end, vim.tbl_extend('force', opts, { desc = 'Toggle case sensitivity' }))
      end,
    })

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
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ua")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
        Snacks.toggle.new({ id = 'grapple', name = 'Grapple Menu', set = function() require("grapple").toggle_tags() end })
            :map("<leader>um")

        Snacks.toggle({
          name = 'quicker',
          set = function()
            require('quicker').toggle()
          end
        }):map("<leader>uq")

        Snacks.toggle({
          name = 'grug-far',
          set = function()
            require('grug-far').toggle_instance({
              instanceName = 'far',
              staticTitle = 'Find and Replace'
            })
          end,
        }):map('<leader>ut')

        Snacks.toggle({
          name = 'Undotree',
          set = function()
            vim.cmd.UndotreeToggle()
          end
        }):map("<leader>uu")

        Snacks.toggle.new({
          id = "git_blame",
          name = " Git Blame",
          get = function()
            return require("gitsigns.config").config.current_line_blame
          end,
          set = function(state)
            require("gitsigns").toggle_current_line_blame(state)
          end,
        })
            :map("<leader>ub")

        Snacks.toggle.new({
          id = "diag_virtual_text",
          name = " Diagnostics Virtual Text",
          get = function()
            return vim.diagnostic.config().virtual_text ~= false
          end,
          set = function(state)
            require("tiny-inline-diagnostic").toggle()
            if state then
              -- NOTE: keep in sync with default in `lsp.lua`
              vim.diagnostic.config({
                virtual_text = { prefix = "", spacing = 2 },
              })
            else
              vim.diagnostic.config({ virtual_text = false })
            end
          end,
        })
            :map("<leader>uv")
      end,
    })
  end,
} }
