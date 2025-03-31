-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- NOTE: Moved to Snacks configuration
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- NOTE: Moved to Snacks configuration
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- NOTE: The following keymaps have been moved to the Snacks configuration:

-- show errors using leaderkey instead of ctrl, blech
-- vim.keymap.set('n', '<leader>pp', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious diagnostic message' })
-- vim.keymap.set('n', '<leader>pn', vim.diagnostic.goto_next, { desc = 'Go to [N]ext diagnostic message' })
-- vim.keymap.set('n', '<leader>ps', vim.diagnostic.open_float, { desc = '[S]how diagnostic under cursor' })
-- vim.keymap.set('n', '<leader>pq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- use leaderkey instead of ctrl for jumping to prev/next jump history
-- vim.keymap.set('n', '<leader>o', '<C-o>', { desc = 'Go to previous cursor position in jump list' })
-- vim.keymap.set('n', '<leader>i', '<C-i>', { desc = 'Go to next cursor position in jump list' })

 
 -- Rebind all Ctrl+w window commands to use leader+j instead
 -- This preserves all the existing window command functionality but changes the prefix
 
 -- Create the mapping from leader+j to Ctrl+w
 -- ughhhhh it not working
 -- vim.keymap.set('n', '<C-w>', '<leader>j', { desc = 'Window command prefix' })
 
-- Rename element keybinding
-- vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, { desc = 'Rename Element' })

-- vim: ts=2 sts=2 sw=2 et
