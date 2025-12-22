# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a LazyVim-based Neovim configuration that extends the LazyVim framework with custom plugins and settings.

### Directory Structure
- `init.lua` - Entry point (bootstraps lazy.nvim, includes Neovide config)
- `lua/config/` - Core configuration overrides
  - `lazy.lua` - Plugin manager setup with LazyVim as base
  - `options.lua` - Vim options (clipboard, folding, scrolloff)
  - `keymaps.lua` - Custom keymaps (undotree toggle, fold navigation, LSP split)
  - `autocmds.lua` - Auto commands (external file change detection)
- `lua/plugins/` - Plugin configurations that extend LazyVim
  - `core.lua` - LazyVim/Snacks.nvim overrides, blink.cmp, bufferline, which-key, treesitter
  - `colorscheme.lua` - Cyberdream theme
  - `ui.lua` - Incline, cursorline, colorful-menu, lualine, oklch-color-picker
  - `lsp.lua` - typescript-tools, tailwind-tools, tiny-inline-diagnostic
  - `utils.lua` - karen-yank, mini.move, undotree, jsx-element
  - `conform.lua` - Prettier configuration with project/global config detection
  - `obsidian.lua` - Obsidian.nvim for knowledge management
  - `testing.lua` - Neotest with busted adapter
  - `blame.lua` - Git blame integration

## Development Commands

```bash
# Test configuration with clean slate
nvim --clean -u init.lua

# Check health
nvim --headless -c "lua vim.health.check()" -c "qa"

# Format Lua files
stylua .

# Plugin management (inside Neovim)
:Lazy              # Plugin status
:Lazy update       # Update plugins
:Lazy profile      # Startup profiling
```

## Key Configuration Choices

### Disabled LazyVim Defaults
Several default keymaps are explicitly disabled in `core.lua`:
- `<leader>fF`, `<leader>fR`, `<leader>sG`, `<leader>sW`, `<leader>gG`, `<leader>E`

### LSP Configuration
- typescript-tools.nvim replaces vtsls/ts_ls (disabled in `lsp.lua`)
- Formatting delegated to Prettier via conform.nvim (typescript-tools formatting disabled)
- Inlay hints enabled for TypeScript/JavaScript

### Snacks.nvim Customizations
- Explorer auto-closes, has sidebar layout with preview
- Picker searches include hidden files
- Smooth scroll animation configured
- LazyGit for git operations (`<leader>gg`)

### Formatter Setup
Prettier configuration in `conform.lua`:
1. Local project config takes precedence
2. Falls back to global config in nvim config directory
3. Auto-detects and uses prettier-plugin-tailwindcss if installed
4. `DISABLE_GLOBAL_PRETTIER_CONFIG` env var disables global fallback

### Custom Keybindings
| Binding | Action |
|---------|--------|
| `<leader>uu` | Toggle Undotree |
| `<leader>fr` / `<leader><space>` | Recent files (cwd) |
| `gl` | Go to definition in vertical split |
| `z-` / `z=` | Decrease/increase fold level |
| `<A-hjkl>` | Move lines/selection (mini.move) |
| `<leader>io/ia/ir/is/if` | TypeScript import operations |
| `<leader>o*` | Obsidian commands |
| `<leader>v` | Color picker under cursor |

## Plugin Conventions

- All plugin configs return a table/array of lazy.nvim specs
- Use `opts` for configuration when possible (merged with defaults)
- Use `config` function only when `opts` isn't sufficient
- Disable conflicting LazyVim keymaps with `{ "<key>", false }`

## Formatting

Stylua configuration (`stylua.toml`):
- 2-space indentation
- 120 column width
