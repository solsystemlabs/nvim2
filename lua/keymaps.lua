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
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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

-- =====================================================
-- Tab management keybindings
-- =====================================================

-- Create a new tab
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = '[T]ab [N]ew', silent = true })

-- Close current tab
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = '[T]ab [C]lose', silent = true })

-- Navigate to next/previous tab
vim.keymap.set('n', '<leader>tl', ':tabnext<CR>', { desc = '[T]ab Next (Right)', silent = true })
vim.keymap.set('n', '<leader>th', ':tabprevious<CR>', { desc = '[T]ab Previous (Left)', silent = true })

-- Alternative navigation with shift-h and shift-l (common vim approach)
vim.keymap.set('n', '<S-l>', ':tabnext<CR>', { desc = 'Tab Next', silent = true })
vim.keymap.set('n', '<S-h>', ':tabprevious<CR>', { desc = 'Tab Previous', silent = true })

-- Go to specific tab by number (1-9)
-- for i = 1, 9 do
--   vim.keymap.set('n', '<leader>' .. i, i .. 'gt', { desc = 'Go to tab ' .. i, silent = true })
-- end

-- Go to last tab
vim.keymap.set('n', '<leader>tL', ':tablast<CR>', { desc = '[T]ab [L]ast', silent = true })

-- Go to first tab
vim.keymap.set('n', '<leader>tF', ':tabfirst<CR>', { desc = '[T]ab [F]irst', silent = true })

-- Move current tab left/right
vim.keymap.set('n', '<leader>tmh', ':-tabmove<CR>', { desc = '[T]ab [M]ove Left', silent = true })
vim.keymap.set('n', '<leader>tml', ':+tabmove<CR>', { desc = '[T]ab [M]ove Right', silent = true })

-- List all tabs
vim.keymap.set('n', '<leader>ts', ':tabs<CR>', { desc = '[T]ab [S]how All', silent = true })
-- vim: ts=2 sts=2 sw=2 et
