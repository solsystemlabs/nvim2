return {
  "mbbill/undotree",
  config = function()
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_DiffAutoOpen = 1
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DiffCommand = "diff"
  end,
}
