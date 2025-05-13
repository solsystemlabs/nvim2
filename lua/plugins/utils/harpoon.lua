return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({})

    -- Integrate with snacks.nvim picker
    vim.keymap.set('n', '<leader>fh', function()
      local Snacks = require('snacks')
      local marks = harpoon:list().items -- Get Harpoon marks
      local items = {}
      for idx, mark in ipairs(marks) do
        table.insert(items, {
          display = mark.value, -- Display the file path in the picker
          file = mark.value,    -- Provide the file path for snacks.nvim
          value = idx,          -- Keep the index for selection
        })
      end
      Snacks.picker.pick('Harpoon Marks', {
        items = items,
        callback = function(item)
          if item then
            harpoon:list():select(item.value)
          end
        end,
      })
    end, { desc = 'Harpoon: Find marks with snacks picker' })
  end,
}
