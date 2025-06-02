-- arrow.lua
-- Arrow.nvim - Bookmarks for frequently used files
-- https://github.com/otavioschwanck/arrow.nvim

return {
  'otavioschwanck/arrow.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    -- optional for file preview
    { 'nvim-lua/plenary.nvim' },
  },
  opts = {
    show_icons = true,
    leader_key = ';',        -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mapping

    -- Window configuration
    window = {
      width = 'auto',
      height = 'auto',
      row = 'auto',
      col = 'auto',
      border = 'double',
    },

    -- Separate bookmarks per git branch
    separate_by_branch = true,

    -- Hide the arrow when there are no bookmarks
    hide_handbook = false,

    -- Save bookmarks to a global file (persists between sessions)
    save_path = function()
      return vim.fn.stdpath("cache") .. "/arrow"
    end,

    -- Save key mappings (set to false if you want manual save only)
    save_key = "cwd", -- or "git_root" for git-based saving

    -- Mappings configuration
    mappings = {
      edit = "e",
      delete_mode = "d",
      clear_all_items = "C",
      toggle = "s", -- used as save if separate_save_and_remove is true
      open_vertical = "v",
      open_horizontal = "-",
      quit = "q",
      remove = "x", -- only used if separate_save_and_remove is true
      next_item = "]",
      prev_item = "["
    },

    -- Custom actions when opening files
    -- custom_actions = {
    --   open = function(target_file_name, current_file_name) -- target_file_name = file selected to be opened, current_file_name = filename from where arrow was called
    --     -- You can add custom logic here, for example:
    --     -- vim.cmd("edit " .. target_file_name)
    --   end,
    --   split_vertical = function(target_file_name, current_file_name)
    --     -- vim.cmd("vsplit " .. target_file_name)
    --   end,
    --   split_horizontal = function(target_file_name, current_file_name)
    --     -- vim.cmd("split " .. target_file_name)
    --   end,
    -- },

    -- Index display mode
    index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
    full_path_list = { "update_stuff" },                                 -- filenames on this list will ALWAYS show the file path too

    -- Always show file paths
    always_show_path = false,

    -- Separate save and remove
    separate_save_and_remove = false,

    -- Global bookmarks (not per-directory)
    global_bookmarks = false,

    -- Per buffer bookmarks
    per_buffer_config = {
      lines = 4,                 -- Number of lines showed on preview.
      sort_automatically = true, -- Auto sort buffer bookmarks
      satellite = {              -- defualt to nil, display arrow index in scrollbar at every bookmark
        enable = true,
        overlap = true,
        priority = 1000,
      },
      zindex = 10,              --default 50
      treesitter_context = nil, -- it can be { line_shift_down = 2 }, currently not usable, for detail see https://github.com/otavioschwanck/arrow.nvim/pull/43
    },
  },

  keys = {
    -- Main arrow toggle (using ; as leader key from config)
    { ";",          function() require("arrow.persist").toggle() end,        desc = "Toggle Arrow bookmarks" },

    -- Quick bookmark management
    { "<leader>ba", function() require("arrow.persist").toggle() end,        desc = "[B]ookmarks [A]rrow toggle" },
    { "<leader>bc", function() require("arrow.persist").clear_cache() end,   desc = "[B]ookmarks [C]lear cache" },

    -- Per-buffer bookmarks (using 'm' as buffer leader from config)
    { "m",          function() require("arrow.persist").toggle_buffer() end, desc = "Toggle buffer bookmarks" },

    -- Quick navigation to bookmarks by index (1-9)
    { "<leader>1",  function() require("arrow.persist").go_to(1) end,        desc = "Go to bookmark 1" },
    { "<leader>2",  function() require("arrow.persist").go_to(2) end,        desc = "Go to bookmark 2" },
    { "<leader>3",  function() require("arrow.persist").go_to(3) end,        desc = "Go to bookmark 3" },
    { "<leader>4",  function() require("arrow.persist").go_to(4) end,        desc = "Go to bookmark 4" },
    { "<leader>5",  function() require("arrow.persist").go_to(5) end,        desc = "Go to bookmark 5" },
    { "<leader>6",  function() require("arrow.persist").go_to(6) end,        desc = "Go to bookmark 6" },
    { "<leader>7",  function() require("arrow.persist").go_to(7) end,        desc = "Go to bookmark 7" },
    { "<leader>8",  function() require("arrow.persist").go_to(8) end,        desc = "Go to bookmark 8" },
    { "<leader>9",  function() require("arrow.persist").go_to(9) end,        desc = "Go to bookmark 9" },

    -- Navigation between bookmarks
    { "]a",         function() require("arrow.persist").next() end,          desc = "Next arrow bookmark" },
    { "[a",         function() require("arrow.persist").previous() end,      desc = "Previous arrow bookmark" },

    -- Open bookmarks in splits
    {
      "<leader>bv",
      function()
        local arrow = require("arrow.persist")
        arrow.toggle()
        -- Note: The split opening is handled by the plugin's internal mappings ('v' and '-')
      end,
      desc = "[B]ookmarks [V]ertical split mode"
    },
  },

  config = function(_, opts)
    require("arrow").setup(opts)

    -- Auto-save bookmarks when Neovim exits
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        require("arrow.persist").save()
      end,
    })

    -- Optional: Auto-load bookmarks when entering a buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        require("arrow.persist").load_cache_file()
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
