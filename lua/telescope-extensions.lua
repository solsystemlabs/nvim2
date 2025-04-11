local M = {}

-- Function to find files changed ONLY in current branch
-- This excludes commits from master that haven't been pulled
M.find_branch_only_files = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  -- Get current branch name
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local current_branch = handle:read("*a"):gsub("%s+$", "")
  handle:close()

  -- Determine the base branch: try 'main' then 'master'
  local base_branch = ""
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

  -- Find the merge-base (common ancestor) between current branch and base branch
  local handle_merge_base = io.popen("git merge-base " .. base_branch .. " " .. current_branch .. " 2>/dev/null")
  local merge_base = handle_merge_base:read("*a"):gsub("%s+$", "")
  handle_merge_base:close()

  if merge_base == "" then
    vim.notify("Could not find common ancestor with " .. base_branch, vim.log.levels.ERROR)
    return
  end

  -- Get files changed in this branch, ignoring merges and upstream changes
  -- This uses git cherry to find commits unique to this branch
  -- and then extracts the changed files from those commits
  local cmd = string.format([[
    for commit in $(git cherry %s %s | grep ^+ | cut -d' ' -f2); do
      git diff-tree --no-commit-id --name-only -r "$commit"
    done | sort -u
  ]], base_branch, current_branch)

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

  -- Get a list of all candidate files
  local candidate_files = {}
  for file in combined_output:gmatch("[^\r\n]+") do
    if file ~= "" and not seen[file] and vim.fn.filereadable(file) == 1 then
      seen[file] = true
      table.insert(candidate_files, file)
    end
  end

  -- Check each file if it currently has changes compared to master
  for _, file in ipairs(candidate_files) do
    local safe_path = vim.fn.shellescape(file)

    -- Compare current version with base branch
    local diff_cmd = "git diff --name-only " .. base_branch .. " -- " .. safe_path
    local diff_handle = io.popen(diff_cmd)
    local diff_result = diff_handle:read("*a")
    diff_handle:close()

    -- If the file is still different from base branch, add it
    if diff_result ~= "" then
      -- Verify it has actual changes (not just metadata/mode changes)
      local content_diff_cmd = "git diff --unified=3 " .. base_branch .. " -- " .. safe_path
      local content_diff_handle = io.popen(content_diff_cmd)
      local content_diff = content_diff_handle:read("*a")
      content_diff_handle:close()

      -- Look for actual content changes in the diff output
      local has_changes = false
      for line in content_diff:gmatch("[^\r\n]+") do
        -- Check for lines that start with '+' or '-' but not the header markers
        if (line:match("^%+") and not line:match("^%+%+%+")) or
            (line:match("^%-") and not line:match("^%-%-%-")) then
          has_changes = true
          break
        end
      end

      if has_changes then
        table.insert(results, file)
      end
    end

    -- Also check for any working tree changes (staged or unstaged)
    local working_cmd = "git diff HEAD --name-only -- " .. safe_path
    local working_handle = io.popen(working_cmd)
    local working_result = working_handle:read("*a")
    working_handle:close()

    -- If the file has local changes, add it
    if working_result ~= "" then
      -- Check if it's already in the results
      local found = false
      for _, existing_file in ipairs(results) do
        if existing_file == file then
          found = true
          break
        end
      end

      -- Add if not already added
      if not found then
        table.insert(results, file)
      end
    end
  end

  if #results == 0 then
    vim.notify("No branch-only changed files found", vim.log.levels.INFO)
    return
  end

  -- Create a diff previewer
  local diff_previewer = previewers.new_buffer_previewer {
    title = "Changes",
    define_preview = function(self, entry, status)
      local file_path = entry.path
      local safe_path = vim.fn.shellescape(file_path)

      -- Set buffer content with only the relevant changes
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {})

      -- Process the diff output
      local changes_only = {}

      -- First check diff against base branch
      local branch_diff_cmd = "git diff --unified=3 --color=never " .. base_branch .. " -- " .. safe_path
      local branch_diff_handle = io.popen(branch_diff_cmd)
      local branch_diff_result = branch_diff_handle:read("*a")
      branch_diff_handle:close()

      -- Process the branch diff
      local in_hunk = false
      local last_was_hunk_header = false

      for line in branch_diff_result:gmatch("[^\r\n]+") do
        -- Skip git headers (lines starting with "diff", "index", "---", "+++")
        if line:match("^diff ") or line:match("^index ") or line:match("^%-%-%-") or line:match("^%+%+%+") then
          -- Skip these lines
          -- Keep hunk headers and content (lines starting with "@@", "+", "-", or " ")
        elseif line:match("^@@") then
          -- Add a blank line between hunks for better readability
          if in_hunk and #changes_only > 0 and not last_was_hunk_header then
            table.insert(changes_only, "")
          end

          in_hunk = true
          last_was_hunk_header = true

          -- Extract just the line numbers from the hunk header
          local line_info = line:match("@@ %-%d+,%d+ %+%d+,%d+ @@")
          if line_info then
            table.insert(changes_only, line_info)
          else
            table.insert(changes_only, line)
          end
        elseif in_hunk and (line:match("^%+") or line:match("^%-") or line:match("^ ")) then
          last_was_hunk_header = false
          table.insert(changes_only, line)
        end
      end

      -- Check for working tree changes (combines staged and unstaged)
      -- Only if we don't already have branch changes or the branch changes don't cover working tree
      local have_branch_changes = #changes_only > 0

      if not have_branch_changes then
        local working_diff_cmd = "git diff HEAD --unified=3 --color=never -- " .. safe_path
        local working_diff_handle = io.popen(working_diff_cmd)
        local working_diff_result = working_diff_handle:read("*a")
        working_diff_handle:close()

        -- Process working tree changes
        in_hunk = false
        last_was_hunk_header = false

        for line in working_diff_result:gmatch("[^\r\n]+") do
          if line:match("^diff ") or line:match("^index ") or line:match("^%-%-%-") or line:match("^%+%+%+") then
            -- Skip these lines
          elseif line:match("^@@") then
            if in_hunk and #changes_only > 0 and not last_was_hunk_header then
              table.insert(changes_only, "")
            end

            in_hunk = true
            last_was_hunk_header = true

            local line_info = line:match("@@ %-%d+,%d+ %+%d+,%d+ @@")
            if line_info then
              table.insert(changes_only, line_info)
            else
              table.insert(changes_only, line)
            end
          elseif in_hunk and (line:match("^%+") or line:match("^%-") or line:match("^ ")) then
            last_was_hunk_header = false
            table.insert(changes_only, line)
          end
        end
      end

      -- Set the buffer content
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, changes_only)

      -- Set diff syntax highlighting
      vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'diff')
    end
  }

  -- Create a picker to show these files
  pickers.new({}, {
    prompt_title = "Branch-only Files",
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
    previewer = diff_previewer,
  }):find()
end

return M
