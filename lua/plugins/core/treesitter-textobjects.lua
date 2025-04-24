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
        }
      }
    })
  end
}
