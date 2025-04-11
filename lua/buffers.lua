local M = {}

-- Function to close all buffers except the current one
function M.close_all_buffers_except_current()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Get all buffer numbers
  local buffers = vim.api.nvim_list_bufs()

  -- Filter buffers to only listed ones that aren't the current buffer
  -- This avoids trying to close special buffers like the dashboard, explorer, etc.
  local buffers_to_close = vim.tbl_filter(function(buf)
    return buf ~= current_buf
        and vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buflisted
  end, buffers)

  -- Delete all other buffers
  for _, buf in ipairs(buffers_to_close) do
    -- Use Snacks.bufdelete to properly close buffers
    Snacks.bufdelete({ buf = buf })
  end

  vim.notify("Closed all buffers except current", vim.log.levels.INFO)
end

-- Function to close all buffers, keeping only special buffers like explorer
function M.close_all_buffers()
  local buffers = vim.api.nvim_list_bufs()

  -- Filter to only listed buffers
  local buffers_to_close = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
  end, buffers)

  -- Delete all buffers
  for _, buf in ipairs(buffers_to_close) do
    Snacks.bufdelete({ buf = buf })
  end

  vim.notify("Closed all buffers", vim.log.levels.INFO)
end

-- Function to close all unmodified buffers
function M.close_unmodified_buffers()
  local buffers = vim.api.nvim_list_bufs()

  -- Filter to only unmodified listed buffers
  local buffers_to_close = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buflisted
        and not vim.bo[buf].modified
  end, buffers)

  -- Delete all unmodified buffers
  for _, buf in ipairs(buffers_to_close) do
    Snacks.bufdelete({ buf = buf })
  end

  vim.notify("Closed all unmodified buffers", vim.log.levels.INFO)
end

-- Function to close buffers to the left of current
function M.close_buffers_to_left()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  -- Find current buffer index
  local current_index = 0
  for i, buf in ipairs(buffers) do
    if buf == current_buf then
      current_index = i
      break
    end
  end

  -- Close all buffers before current_index
  for i = 1, current_index - 1 do
    local buf = buffers[i]
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      Snacks.bufdelete({ buf = buf })
    end
  end

  vim.notify("Closed buffers to the left", vim.log.levels.INFO)
end

-- Function to close buffers to the right of current
function M.close_buffers_to_right()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  -- Find current buffer index
  local current_index = 0
  for i, buf in ipairs(buffers) do
    if buf == current_buf then
      current_index = i
      break
    end
  end

  -- Close all buffers after current_index
  for i = current_index + 1, #buffers do
    local buf = buffers[i]
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      Snacks.bufdelete({ buf = buf })
    end
  end

  vim.notify("Closed buffers to the right", vim.log.levels.INFO)
end

-- Function to show a list of modified buffers
function M.list_modified_buffers()
  local buffers = vim.api.nvim_list_bufs()

  -- Filter to only modified listed buffers
  local modified_buffers = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buflisted
        and vim.bo[buf].modified
  end, buffers)

  if #modified_buffers == 0 then
    vim.notify("No modified buffers found", vim.log.levels.INFO)
    return
  end

  -- Use Snacks picker to show only modified buffers
  Snacks.picker.buffers({
    modified = true,
    title = "Modified Buffers"
  })
end

-- Function to check if there are modified buffers
function M.has_modified_buffers()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf)
        and vim.bo[buf].buflisted
        and vim.bo[buf].modified then
      return true
    end
  end

  return false
end

-- Return the module
return M
