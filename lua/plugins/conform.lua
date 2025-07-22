return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Add formatters by file type
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.astro = { "prettier" }
    opts.formatters_by_ft.typescript = { "prettier" }
    opts.formatters_by_ft.typescriptreact = { "prettier" }
    opts.formatters_by_ft.javascript = { "prettier" }
    opts.formatters_by_ft.javascriptreact = { "prettier" }
    opts.formatters_by_ft.html = { "prettier" }
    opts.formatters_by_ft.css = { "prettier" }
    opts.formatters_by_ft.scss = { "prettier" }
    opts.formatters_by_ft.markdown = { "prettier" }
    opts.formatters_by_ft.yaml = { "prettier" }
    opts.formatters_by_ft.graphql = { "prettier" }
    opts.formatters_by_ft.vue = { "prettier" }
    opts.formatters_by_ft.angular = { "prettier" }
    opts.formatters_by_ft.less = { "prettier" }
    opts.formatters_by_ft.flow = { "prettier" }

    -- Customize prettier formatter
    opts.formatters = opts.formatters or {}
    opts.formatters.prettier = {
      args = function(_, ctx)
        local prettier_roots = { ".prettierrc", ".prettierrc.json", "prettier.config.js" }
        local args = { "--stdin-filepath", "$FILENAME" }
        local config_path = vim.fn.stdpath("config")

        local localPrettierConfig = vim.fs.find(prettier_roots, {
          upward = true,
          path = ctx.dirname,
          type = "file",
        })[1]
        local globalPrettierConfig = vim.fs.find(prettier_roots, {
          path = type(config_path) == "string" and config_path or config_path[1],
          type = "file",
        })[1]
        local disableGlobalPrettierConfig = os.getenv("DISABLE_GLOBAL_PRETTIER_CONFIG")

        -- Project config takes precedence over global config
        if localPrettierConfig then
          vim.list_extend(args, { "--config", localPrettierConfig })
        elseif globalPrettierConfig and not disableGlobalPrettierConfig then
          vim.list_extend(args, { "--config", globalPrettierConfig })
        end

        local hasTailwindPrettierPlugin = vim.fs.find("node_modules/prettier-plugin-tailwindcss", {
          upward = true,
          path = ctx.dirname,
          type = "directory",
        })[1]

        if hasTailwindPrettierPlugin then
          vim.list_extend(args, { "--plugin", "prettier-plugin-tailwindcss" })
        end

        return args
      end,
    }

    -- Configure format on save to skip node_modules
    -- opts.format_on_save = function(bufnr)
    --   local bufname = vim.api.nvim_buf_get_name(bufnr)
    --   if bufname:match("/node_modules/") then
    --     return
    --   end
    --   return { timeout_ms = 1000, lsp_fallback = true }
    -- end

    return opts
  end,
}
