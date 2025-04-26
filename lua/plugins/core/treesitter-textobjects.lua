return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  config = function()
    local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['so'] = '@assignment.outer',
            ['sl'] = '@assignment.lhs',
            ['si'] = '@assignment.outer',
            ['sr'] = '@assignment.rhs',
            ['ab'] = '@attribute.outer',
            ['ib'] = '@attribute.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['ai'] = '@conditional.outer',
            ['ii'] = '@conditional.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['ag'] = '@regex.outer',
            ['ig'] = '@regex.inner',
            ['ar'] = '@return.outer',
            ['ir'] = '@return.inner',
            ['ap'] = '@parameter.outer',
            ['ip'] = '@parameter.inner',
            ['at'] = '@comment.outer',
            ['it'] = '@comment.inner',
            ['in'] = '@number.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = 'Next function start' },
            [']]'] = { query = '@class.outer', desc = 'Next class start' },
            [']p'] = { query = '@parameter.outer', desc = 'Next parameter start' },
          },
          goto_next_end = {
            [']M'] = { query = '@function.outer', desc = 'Next function end' },
            [']['] = { query = '@class.outer', desc = 'Next class end' },
            [']P'] = { query = '@parameter.outer', desc = 'Next parameter end' },
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = 'Previous function start' },
            ['[['] = { query = '@class.outer', desc = 'Previous class start' },
            ['[p'] = { query = '@parameter.outer', desc = 'Previous parameter start' },
          },
          goto_previous_end = {
            ['[M'] = { query = '@function.outer', desc = 'Previous function end' },
            ['[]'] = { query = '@class.outer', desc = 'Previous class end' },
            ['[P'] = { query = '@parameter.outer', desc = 'Previous parameter end' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>sn'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>sp'] = '@parameter.inner',
          },
        },
      }
    })

    -- Set up repeatable movements with ; and ,
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat last textobject move forward" })
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat last textobject move backward" })

    -- Optionally, make builtin f, F, t, T repeatable
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f, { desc = "Repeatable find forward" })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F, { desc = "Repeatable find backward" })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t, { desc = "Repeatable till forward" })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T, { desc = "Repeatable till backward" })
  end
}
