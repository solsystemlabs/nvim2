return { {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    layout = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Preserve your existing keybindings but use Snacks API
    -- File searching and navigation
    { "<leader>sf",       function() Snacks.picker.files() end,                                   desc = "[S]earch [F]iles" },
    { "<leader>sh",       function() Snacks.picker.help() end,                                    desc = "[S]earch [H]elp" },
    { "<leader>sw",       function() Snacks.picker.grep_word() end,                               desc = "[S]earch current [W]ord" },
    { "<leader>sg",       function() Snacks.picker.grep() end,                                    desc = "[S]earch by [G]rep" },
    { "<leader>sd",       function() Snacks.picker.diagnostics() end,                             desc = "[S]earch [D]iagnostics" },
    { "<leader>sr",       function() Snacks.picker.resume() end,                                  desc = "[S]earch [R]esume" },
    { "<leader>s.",       function() Snacks.picker.recent() end,                                  desc = "[S]earch Recent Files ('.' for repeat)" },
    { "<leader><leader>", function() Snacks.picker.buffers() end,                                 desc = "[ ] Find existing buffers" },
    { "<leader>sk",       function() Snacks.picker.keymaps() end,                                 desc = "[S]earch [K]eymaps" },
    { "<leader>ss",       function() Snacks.picker.lsp_symbols() end,                             desc = "[S]earch [S]ymbols" },
    { "<leader>sn",       function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },

    -- LSP navigation
    { "gd",               function() Snacks.picker.lsp_definitions() end,                         desc = "[G]oto [D]efinition" },
    { "gr",               function() Snacks.picker.lsp_references() end,                          desc = "[G]oto [R]eferences" },
    { "gI",               function() Snacks.picker.lsp_implementations() end,                     desc = "[G]oto [I]mplementation" },
    { "<leader>D",        function() Snacks.picker.lsp_type_definitions() end,                    desc = "Type [D]efinition" },
    { "<leader>ds",       function() Snacks.picker.lsp_symbols() end,                             desc = "[D]ocument [S]ymbols" },
    { "<leader>ws",       function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "[W]orkspace [S]ymbols" },

    -- Search within buffer
    {
      "<leader>/",
      function()
        Snacks.picker.lines({
          winblend = 10,
          previewer = false,
        })
      end,
      desc = "[/] Fuzzily search in current buffer"
    },

    -- Search in open files
    {
      "<leader>s/",
      function()
        Snacks.picker.grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end,
      desc = "[S]earch [/] in Open Files"
    },

    -- File explorer
    { "<leader>e",  function() Snacks.explorer() end,             desc = "Open File [E]xplorer" },

    -- Undotree
    { "<leader>u",  function() vim.cmd.UndotreeToggle() end,      desc = "Toggle [U]ndotree" },

    -- Terminal
    { "<Esc><Esc>", "<C-\\><C-n>",                                mode = "t",                                          desc = "Exit terminal mode" },

    -- Diagnostic navigation
    { "<leader>pp", function() vim.diagnostic.goto_prev() end,    desc = "Go to [P]revious diagnostic message" },
    { "<leader>pn", function() vim.diagnostic.goto_next() end,    desc = "Go to [N]ext diagnostic message" },
    { "<leader>ps", function() vim.diagnostic.open_float() end,   desc = "[S]how diagnostic under cursor" },
    { "<leader>pq", function() vim.diagnostic.setloclist() end,   desc = "Open diagnostic [Q]uickfix list" },

    -- Jump list navigation
    { "<leader>o",  "<C-o>",                                      desc = "Go to previous cursor position in jump list" },
    { "<leader>i",  "<C-i>",                                      desc = "Go to next cursor position in jump list" },

    -- Window navigation
    { "<C-h>",      "<C-w><C-h>",                                 desc = "Move focus to the left window" },
    { "<C-l>",      "<C-w><C-l>",                                 desc = "Move focus to the right window" },
    { "<C-j>",      "<C-w><C-j>",                                 desc = "Move focus to the lower window" },
    { "<C-k>",      "<C-w><C-k>",                                 desc = "Move focus to the upper window" },

    -- Notification
    { "<leader>n",  function() Snacks.picker.notifications() end, desc = "Notification History" },

    -- Zen mode
    { "<leader>z",  function() Snacks.zen() end,                  desc = "Toggle Zen Mode" },
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

        -- Create some toggle mappings (preserving your existing toggle functionality)
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>th") -- Preserving your existing toggle for inlay hints
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
} }
