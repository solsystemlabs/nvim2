return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })
    
    -- Extend snacks.picker to include Harpoon functionality
    local snacks_picker = require("snacks.picker")
    snacks_picker.harpoon_files = function()
      local list = harpoon:list()
      local items = {}
      for idx, item in ipairs(list.items) do
        table.insert(items, {
          display = string.format("%d: %s", idx, item.value),
          value = item,
          ordinal = tostring(idx),
        })
      end
      
      snacks_picker.pick({
        title = "Harpoon Marks",
        items = items,
        format_item = function(item)
          return item.display
        end,
        on_select = function(item)
          local buf_id = vim.fn.bufadd(item.value.value)
          vim.fn.bufload(buf_id)
          vim.api.nvim_set_current_buf(buf_id)
          if item.value.context.row then
            vim.api.nvim_win_set_cursor(0, {item.value.context.row, item.value.context.col or 0})
          end
        end,
      })
    end
  end,
}
