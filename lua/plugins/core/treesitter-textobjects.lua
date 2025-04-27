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
            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        },
      }
    })

    -- Set up repeatable movements with ; and ,    -- Set up repeatable movements with ; and ,
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next,
      { desc = "Repeat last textobject move forward" })
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous,
      { desc = "Repeat last textobject move backward" })
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous,
      { desc = "Repeat last textobject move backward" })

    -- Optionally, make builtin f, F, t, T repeatable
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f, { desc = "Repeatable find forward" })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F, { desc = "Repeatable find backward" })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t, { desc = "Repeatable till forward" })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T, { desc = "Repeatable till backward" })
  end
}
