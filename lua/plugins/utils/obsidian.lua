-- obsidian.lua
-- Integration with Obsidian.nvim for note-taking and knowledge management
-- https://github.com/epwalsh/obsidian.nvim

return {
  "epwalsh/obsidian.nvim",
  version = "*",                                    -- Recommended to use latest release instead of latest commit
  lazy = false,                                     -- Set to false to ensure the plugin loads properly even when not in a vault
  event = { "BufReadPre *.md", "BufNewFile *.md" }, -- Load for markdown files
  dependencies = {
    -- Required dependency
    "nvim-lua/plenary.nvim",

    -- Optional dependencies for better experience
    "hrsh7th/nvim-cmp",              -- For completion support
    "nvim-telescope/telescope.nvim", -- For search and note navigation
  },
  cmd = {                            -- Register all commands for easy access
    "ObsidianOpen", "ObsidianNew", "ObsidianQuickSwitch", "ObsidianFollowLink",
    "ObsidianBacklinks", "ObsidianWorkspace", "ObsidianSearch", "ObsidianLinkNew",
    "ObsidianToday", "ObsidianYesterday", "ObsidianTomorrow", "ObsidianTemplate",
    "ObsidianLinks", "ObsidianTags", "ObsidianRename", "ObsidianExtractNote",
    "ObsidianPasteImg", "ObsidianTOC", "ObsidianNewFromTemplate"
  },
  keys = {
    -- Navigation and basic commands
    { "<leader>on",  "<cmd>ObsidianNew<CR>",             desc = "[N]ew note" },
    { "<leader>oo",  "<cmd>ObsidianOpen<CR>",            desc = "[O]pen in app" },
    { "<leader>of",  "<cmd>ObsidianFollowLink<CR>",      desc = "[F]ollow link" },
    { "<leader>ob",  "<cmd>ObsidianBacklinks<CR>",       desc = "[B]acklinks" },
    { "<leader>ol",  "<cmd>ObsidianLinks<CR>",           desc = "View [L]inks" },

    -- Search and quick navigation
    { "<leader>oq",  "<cmd>ObsidianQuickSwitch<CR>",     desc = "[Q]uick switch" },
    { "<leader>os",  "<cmd>ObsidianSearch<CR>",          desc = "[S]earch" },
    { "<leader>ot",  "<cmd>ObsidianTags<CR>",            desc = "[T]ags" },

    -- Daily notes
    { "<leader>odt", "<cmd>ObsidianToday<CR>",           desc = "[D]aily note (today)" },
    { "<leader>ody", "<cmd>ObsidianYesterday<CR>",       desc = "[Y]esterday note" },
    { "<leader>odm", "<cmd>ObsidianTomorrow<CR>",        desc = "To[m]orrow note" },

    -- Content creation and editing
    { "<leader>op",  "<cmd>ObsidianPasteImg<CR>",        desc = "[P]aste image" },
    { "<leader>oi",  "<cmd>ObsidianTemplate<CR>",        desc = "[I]nsert template" },
    { "<leader>ox",  "<cmd>ObsidianLinkNew<CR>",         desc = "Link new note",               mode = { "n", "v" } },
    { "<leader>oe",  "<cmd>ObsidianExtractNote<CR>",     desc = "[E]xtract selection to note", mode = "v" },

    -- Workspace management
    { "<leader>ow",  "<cmd>ObsidianWorkspace<CR>",       desc = "[W]orkspace" },

    -- Advanced features
    { "<leader>or",  "<cmd>ObsidianRename<CR>",          desc = "[R]ename note" },
    { "<leader>oc",  "<cmd>ObsidianTOC<CR>",             desc = "Table of [C]ontents" },
    { "<leader>ot",  "<cmd>ObsidianNewFromTemplate<CR>", desc = "[N]ew from template" },
  },
  opts = {
    -- Directory where your vaults are stored
    workspaces = {
      {
        name = "work",
        path = "~/Obsidian/work",
      },
      -- You can add more workspaces as needed
      -- {
      --   name = "personal",
      --   path = "~/Obsidian/personal",
      -- },
    },

    -- Path to store new notes (relative to vault root)
    notes_subdir = "notes",

    -- Template directory for new notes (relative to vault root)
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- Set to empty directory if templates dir doesn't exist
      -- This prevents the "not a valid templates directory" error
      folder = nil, -- Will be automatically determined based on the vault
    },

    -- Daily notes settings
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y", -- e.g. January 1, 2023
      -- Optional, if you want to automatically insert a template
      template = nil,
    },

    -- Define the note ID generation format
    -- This will create filenames as title-with-dashes.md
    note_id_func = function(title)
      if title ~= nil then
        -- Convert title to valid filename
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If no title, use timestamp
        return tostring(os.time())
      end
    end,

    -- Completion settings for wiki links and tags
    completion = {
      -- Enable nvim-cmp completion
      nvim_cmp = true,
      -- Trigger completion after typing 2 characters
      min_chars = 2,
    },

    -- Configure how notes are opened
    open_notes_in = "current", -- "current", "vsplit", or "hsplit"

    -- Use Telescope as picker
    picker = {
      name = "telescope.nvim",
      -- Mappings for the picker
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },

    -- Sort search results by modification time (descending)
    sort_by = "modified",
    sort_reversed = true,

    -- UI settings
    ui = {
      enable = true, -- Set to false if you don't want any UI enhancements
    },

    -- Attachment settings for images
    attachments = {
      img_folder = "assets/images", -- Folder for storing images
    },

    -- Image pasting settings
    -- For Linux, requires xclip or wl-clipboard
    -- For macOS, requires pngpaste
    -- For Windows WSL, requires wsl-open
    image_paste_title = function()
      -- Prefix images with timestamp
      return os.date("%Y%m%d%H%M%S")
    end,

    -- Custom mappings for obsidian functionality
    mappings = {
      -- Override gf to follow obsidian links properly
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
  },
}
