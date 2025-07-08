# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a LazyVim-based Neovim configuration that follows the LazyVim plugin architecture:

- `init.lua` - Entry point that bootstraps lazy.nvim
- `lua/config/` - Core LazyVim configuration overrides
  - `lazy.lua` - Plugin manager setup with LazyVim defaults
  - `options.lua` - Vim options and settings
  - `keymaps.lua` - Custom key mappings
  - `autocmds.lua` - Auto commands
- `lua/plugins/` - Custom plugin configurations that extend LazyVim
  - `core.lua` - Core LazyVim and Snacks.nvim customizations
  - `colorscheme.lua` - Gruvbox theme configuration
  - `jujutsu.lua` - Custom jj-nvim plugin (local development plugin)
  - `undotree.lua` - Undo tree plugin
  - `example.lua` - Template for new plugins

## Key Configuration Details

### Plugin Management
- Uses lazy.nvim as the plugin manager
- Extends LazyVim base configuration rather than replacing it
- Custom plugins are loaded from `lua/plugins/` directory
- Plugin updates are automatically checked but notifications are disabled

### Custom Plugins
- **jj-nvim**: Local development plugin for Jujutsu VCS integration (located at `~/projects/jj-nvim/`)
- **Gruvbox**: Primary colorscheme with inverted tabline
- **Undotree**: Accessible via `<leader>uu` keybinding

### Code Formatting
- Uses stylua for Lua formatting (configure via `stylua.toml`)
- Formatting settings: 2-space indentation, 120 column width
- Prettier integration enabled without requiring config file

## Development Commands

### Testing Configuration
```bash
# Test the configuration
nvim --clean -u init.lua

# Check for syntax errors
nvim --headless -c "lua vim.health.check()" -c "qa"
```

### Formatting
```bash
# Format Lua files (if stylua is installed)
stylua .

# Format all files in specific directory
stylua lua/
```

### Plugin Management
```bash
# Update plugins (from within Neovim)
:Lazy update

# Check plugin status
:Lazy

# Profile startup time
:Lazy profile
```

## File Structure Conventions

- All plugin configurations return a table/array of plugin specs
- Follow LazyVim's plugin specification format
- Custom keymaps should be defined in plugin specs or `keymaps.lua`
- Use `opts` table for plugin configuration when possible
- Local development plugins should use `dir` instead of repository URL

## Custom Keybindings

- `<leader>uu` - Toggle Undotree
- `<leader>fr` - Recent files (current working directory)
- `<leader>fR` - Recent files (global)

## Alternative Configuration Reference

The `~/.config/nvim-mine` directory contains a comprehensive kickstart-modular based configuration that serves as a reference for advanced plugin setups. This configuration includes:

### Core Framework
- **Snacks.nvim**: Central UI framework providing dashboard, picker, explorer, terminal, notifications, and extensive keybindings
- **Telescope**: Enhanced fuzzy finder with custom path display
- **Nvim-cmp**: Intelligent autocompletion with multiple sources (LuaSnip, LSP, path, signature help)

### Advanced Features
- **Obsidian.nvim**: Full knowledge management integration with workspace support, daily notes, and wiki-style linking
- **Grapple**: Git-scoped file tagging system for quick navigation
- **Arrow**: Per-branch file bookmarks with quick access shortcuts
- **Grug-far**: Advanced project-wide search and replace with visual interface

### Version Control Integration
- **Jujutsu**: Modern VCS with custom jj-nvim plugin, floating windows, and specialized conflict resolution
- **Lazyjj**: Terminal UI for Jujutsu operations
- **Enhanced Git**: Advanced blame, diff, and hunk management

### Development Tools
- **TypeScript-tools**: Specialized TypeScript/JavaScript language server with import management
- **Tailwind-tools**: Enhanced Tailwind CSS development experience
- **Overseer**: Task runner with custom templates (pnpm lint)
- **TSC**: TypeScript compilation with quickfix integration

### UI Enhancements
- **Incline**: Floating window labels with git diff and diagnostics
- **Lualine**: Status line with Jujutsu/Git commit info and Grapple bookmark status
- **Trouble**: Enhanced diagnostic and error navigation
- **Render-markdown**: Enhanced markdown rendering

### Productivity Features
- **Auto-session**: Git branch-specific session management
- **Yazi**: Terminal file manager with floating window integration
- **Todo-comments**: Task management within code
- **Leap**: Improved vim-sneak for quick navigation

The nvim-mine configuration demonstrates advanced patterns for:
- Modular plugin organization (core/experimental/lsp/ui/utils/vcs)
- Extensive keybinding organization with Which-key
- Integration between different tools for cohesive workflow
- Modern VCS integration (Jujutsu)
- Knowledge management workflows

## LazyVim Ecosystem Reference

For comprehensive understanding of LazyVim architecture, patterns, and best practices, see [LAZYVIM.md](./LAZYVIM.md) which contains:

- Core LazyVim architecture and philosophy
- Plugin system patterns and conventions
- Configuration best practices
- Available extras and extension points
- Advanced customization techniques
- Common development workflows