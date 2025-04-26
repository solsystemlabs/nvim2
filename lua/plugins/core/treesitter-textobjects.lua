return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  config = function()
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
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
            [']p'] = '@parameter.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
            [']P'] = '@parameter.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[p'] = '@parameter.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
            ['[P'] = '@parameter.outer',
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
  end
}
