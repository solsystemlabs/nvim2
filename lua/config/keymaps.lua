-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

Snacks.toggle({
  name = "Undotree",
  set = function()
    vim.cmd.UndotreeToggle()
  end,
}):map("<leader>uu")

vim.keymap.set("n", "gl", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in vertical split" })

-- Fold navigation
vim.keymap.set("n", "z-", "<Cmd>set foldlevel-=1<CR>zz", { desc = "Decrease fold level" })
vim.keymap.set("n", "z=", "<Cmd>set foldlevel+=1<CR>zz", { desc = "Increase fold level" })
vim.keymap.set("n", "zj", "zjzxzz", { desc = "Next fold (collapse others)" })
vim.keymap.set("n", "zk", "zkzxzz", { desc = "Previous fold (collapse others)" })
