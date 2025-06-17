# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a highly modular Neovim configuration based on kickstart-modular.nvim, using Lazy.nvim for plugin management. The configuration is organized into logical categories with extensive customization for development workflows, particularly TypeScript/React development and database work.

## Configuration Architecture

**Entry Point:** `init.lua` - Sets up leader keys, basic settings, and loads core modules in order:
1. `options` - Editor settings 
2. `keymaps` - Basic key mappings
3. `lazy-bootstrap` - Auto-installs Lazy.nvim
4. `lazy-plugins` - Loads all plugin configurations

**Plugin Organization:** All plugins are in `lua/plugins/` with categorical structure:
- `core/` - Essential functionality (snacks, telescope, treesitter, etc.)
- `experimental/` - Features being tested (grug-far, arrow, hbac, etc.) 
- `lsp/` - Language servers and diagnostics
- `testing/` - Testing tools
- `ui/` - Interface enhancements
- `utils/` - Utility plugins
- `vcs/` - Version control tools

**Key Architecture Notes:**
- Snacks.nvim serves as the central UI/UX framework (largest config at 432 lines)
- Heavy use of lazy loading for performance
- Custom telescope extensions for Git branch-based file finding
- Database development integration (dadbod-explorer)
- Multiple Git tools (gitsigns, lazyjj, jujutsu)

## Common Development Commands

**Plugin Management:**
- `:Lazy` - Open plugin manager interface
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins

**LSP and Diagnostics:**
- `:Mason` - Open LSP server installer
- `:LspInfo` - Show LSP client information
- `:ConformInfo` - Show formatter status

**Key Leader Mappings (Space):**
- `<leader>ff` - Find files with telescope
- `<leader>fg` - Live grep in files
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags

**Database Development:**
- Database URL is configured in init.lua
- Use dadbod-explorer for database interaction

## File Structure

**Configuration Files:**
- `init.lua` - Main entry point
- `lua/options.lua` - Editor options and settings
- `lua/keymaps.lua` - Basic keymaps and tab management
- `lua/lazy-plugins.lua` - Central plugin loader
- `lazy-lock.json` - Plugin version lockfile (tracked in git)

**Plugin Configurations:**
Each plugin has its own file in appropriate category directory. Major configs include:
- `lua/plugins/core/snacks.lua` - Central UI framework (432 lines)
- `lua/plugins/core/telescope.lua` - Fuzzy finder configuration
- `lua/plugins/lsp/lspconfig.lua` - LSP setup with Mason (203 lines)
- `lua/plugins/experimental/arrow.lua` - File navigation (152 lines)

## Development Workflow

**Language Support:**
- Primary focus on TypeScript/React (evident from LSP configs)
- Full LSP integration with Mason for easy language server management
- Tailwind CSS support via tailwind-tools.nvim
- Database development capabilities

**Version Control:**
- Multiple Git integrations available
- Custom branch-based file finding via telescope extensions
- GitLab integration for enterprise workflows
- Jujutsu version control system support

**Key Features:**
- Auto-session management
- Advanced search/replace with Grug-far
- File tagging system with Grapple
- Buffer management with HBAC
- Extensive keymap system using Snacks dispatcher

## Dependencies

**External Requirements:**
- Git, make, unzip, C compiler (gcc)
- ripgrep (for telescope and search)
- Clipboard tool (xclip/xsel/win32yank)
- Nerd Font (configured with `vim.g.have_nerd_font = true`)
- Node.js/npm (for TypeScript development)

**Plugin Management:**
- Lazy.nvim auto-installs on first run
- 50+ plugins managed via lazy-lock.json
- Modular loading with events and conditions

## Experimental Features

The `experimental/` category contains features being actively tested:
- grug-far.nvim - Advanced find and replace
- arrow.nvim - Smart file navigation
- hbac.nvim - Buffer auto-close management

Monitor these configurations as they may graduate to core or be removed based on utility.