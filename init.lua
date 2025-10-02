-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_position_animation_length = 0.1
end
require("config.lazy")
