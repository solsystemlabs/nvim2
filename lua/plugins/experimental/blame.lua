return {
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup {
      width = 50,
      format = "%s | %t | %a",
      date_format = "%Y-%m-%d",
      max_summary_width = 30,
    }
  end,
}
