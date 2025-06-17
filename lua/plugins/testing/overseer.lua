return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerOpen", "OverseerClose", "OverseerToggle", "OverseerSaveBundle", "OverseerLoadBundle", "OverseerDeleteBundle", "OverseerRunCmd", "OverseerRun", "OverseerInfo", "OverseerBuild", "OverseerQuickAction", "OverseerTaskAction", "OverseerClearCache" },
  opts = {
    strategy = "terminal",
    templates = { "builtin", "user.pnpm_lint" },
    auto_scroll = true,
    auto_detect_success_color = true,
  },
}