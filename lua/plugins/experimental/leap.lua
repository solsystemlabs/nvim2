-- https://github.com/ggandor/leap.nvim
-- Improvement on vim-sneak, allows jumping within a file using up to three characters
return {
  "ggandor/leap.nvim",
  config = function()
    -- require('leap').setup()
    require('leap').set_default_mappings()
  end
}
