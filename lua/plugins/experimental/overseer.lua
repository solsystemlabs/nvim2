return {
  {
    'stevearc/overseer.nvim',
    opts = {
      -- Configuration options for overseer.nvim
      strategy = 'terminal', -- Use terminal strategy by default
      close_on_exit = false, -- Keep the terminal open after task completion
      templates = { 'builtin' },
    },
    config = function(_, opts)
      local overseer = require('overseer')
      overseer.setup(opts)
      
      -- Custom template for npm scripts
      overseer.register_template({
        name = "npm script",
        builder = function(params)
          return {
            cmd = { 'npm', 'run', params.script },
            cwd = vim.fn.getcwd(), -- Run in current working directory
            name = "npm " .. params.script,
          }
        end,
        params = {
          script = {
            type = "enum",
            choices = function()
              -- Dynamically read scripts from package.json
              local package_json_path = vim.fn.findfile('package.json', vim.fn.getcwd() .. ';')
              if package_json_path == '' then
                return { 'No package.json found' }
              end
              
              local content = vim.fn.readfile(package_json_path)
              local package_json = vim.fn.json_decode(content)
              if package_json and package_json.scripts then
                return vim.tbl_keys(package_json.scripts)
              else
                return { 'No scripts found in package.json' }
              end
            end,
          },
        },
        condition = {
          filetype = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
          callback = function()
            return vim.fn.findfile('package.json', vim.fn.getcwd() .. ';') ~= ''
          end,
        },
        desc = "Run an npm script from package.json",
        priority = 50,
      })
      
      -- Keybinding to open the task list
      vim.keymap.set('n', '<leader>vt', '<cmd>OverseerTaskAction<CR>', { desc = 'Open Overseer Task List' })
      vim.keymap.set('n', '<leader>vr', '<cmd>OverseerRun<CR>', { desc = 'Run Overseer Task' })
    end,
  },
}
