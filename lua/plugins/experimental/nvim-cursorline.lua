return {
  "ya2s/nvim-cursorline",
  config = function()
    require('nvim-cursorline').setup {
      cursorline = {
        enable = true,
        timeout = 300,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      }
    }
  end
}
