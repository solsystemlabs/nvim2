-- Step 1: Create a new file at lua/custom/telescope-extensions.lua to hold our custom functions

-- In lua/custom/telescope-extensions.lua
local M = {}

-- Function to find files changed on the current branch
-- compared to the base branch (main/master)
M.find_branch_files = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Try to detect the main/base branch
  local base_branch = ""
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local current_branch = handle:read("*a"):gsub("%s+$", "")
  handle:close()

  -- Determine the base branch: try 'main' then 'master'
  local handle_main = io.popen("git rev-parse --verify main 2>/dev/null")
  local main_exists = handle_main:read("*a")
  handle_main:close()

  if main_exists ~= "" then
    base_branch = "main"
  else
    local handle_master = io.popen("git rev-parse --verify master 2>/dev/null")
    local master_exists = handle_master:read("*a")
    handle_master:close()

    if master_exists ~= "" then
      base_branch = "master"
    end
  end

  if base_branch == "" then
    vim.notify("Could not detect base branch (main/master). Using origin/HEAD instead.", vim.log.levels.WARN)
    base_branch = "origin/HEAD"
  end

  -- Get files changed between base branch and current branch
  local cmd = "git diff --name-only " .. base_branch .. ".." .. current_branch
  local handle_diff = io.popen(cmd)
  local diff_output = handle_diff:read("*a")
  handle_diff:close()

  -- Also get staged and unstaged changes
  local handle_staged = io.popen("git diff --name-only --staged")
  local staged_output = handle_staged:read("*a")
  handle_staged:close()

  local handle_unstaged = io.popen("git diff --name-only")
  local unstaged_output = handle_unstaged:read("*a")
  handle_unstaged:close()

  -- Combine all outputs and split into lines
  local combined_output = diff_output .. staged_output .. unstaged_output
  local results = {}
  local seen = {}

  for file in combined_output:gmatch("[^\r\n]+") do
    if file ~= "" and not seen[file] and vim.fn.filereadable(file) == 1 then
      seen[file] = true
      table.insert(results, file)
    end
  end

  if #results == 0 then
    vim.notify("No changed files found", vim.log.levels.INFO)
    return
  end

  -- Create a picker to show these files
  pickers.new({}, {
    prompt_title = "Branch Files (" .. current_branch .. " vs " .. base_branch .. ")",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
          path = entry,
        }
      end,
    },
    sorter = conf.file_sorter({}),
    previewer = conf.file_previewer({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("edit " .. selection.path)
      end)
      return true
    end,
  }):find()
end

return M
