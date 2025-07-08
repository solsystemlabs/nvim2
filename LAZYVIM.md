# LazyVim Ecosystem Guide

Comprehensive documentation of LazyVim architecture, patterns, and best practices for configuration and extension.

## Core Architecture

### Philosophy
LazyVim is built on lazy.nvim and follows a modular, configuration-driven approach:
- **Pre-configured Foundation**: Provides sane defaults while maintaining full customizability
- **Automatic Loading**: Configuration files are loaded automatically without manual requiring
- **Plugin-First Design**: Core functionality implemented through carefully selected and pre-configured plugins
- **Extensible by Design**: Easy to extend through extras, custom plugins, and configuration overrides

### File Structure
```
~/.config/nvim/
├── lua/
│   ├── config/
│   │   ├── autocmds.lua    # Auto commands (loaded automatically)
│   │   ├── keymaps.lua     # Global keymaps (loaded automatically)
│   │   ├── lazy.lua        # Lazy.nvim setup (loaded automatically)
│   │   └── options.lua     # Neovim options (loaded automatically)
│   └── plugins/
│       ├── *.lua           # Plugin specifications (all loaded automatically)
│       └── core.lua        # Core LazyVim settings (colorscheme, icons, etc.)
└── init.lua
```

### Key Principles
- Files in `lua/config/` are loaded automatically - never manually `require` them
- All files in `lua/plugins/` are automatically loaded by lazy.nvim
- Configuration follows lazy.nvim's plugin specification format

## Plugin System

### Core Plugin Categories
1. **Coding**: Snippets, autocompletion, text objects (mini.pairs, ts-comments.nvim, mini.ai)
2. **Colorscheme**: Default themes (TokyoNight, Catppuccin)
3. **Editor**: File exploration, search, git integration (grug-far.nvim, flash.nvim, gitsigns.nvim)
4. **Formatting**: Code formatting via conform.nvim
5. **Linting**: Code linting through nvim-lint
6. **LSP**: Language Server Protocol configuration
7. **TreeSitter**: Advanced syntax highlighting
8. **UI**: Interface enhancements (status lines, buffer lines, icons)
9. **Util**: Session management and shared functionality

### Plugin Configuration Patterns

#### Adding a New Plugin
```lua
return {
  "ellisonleao/gruvbox.nvim",
  opts = { transparent = true }
}
```

#### Disabling a Plugin
```lua
return {
  "folke/trouble.nvim",
  enabled = false
}
```

#### Modifying Existing Plugin
```lua
return {
  "nvim-cmp",
  opts = function(_, opts)
    table.insert(opts.sources, { name = "emoji" })
  end
}
```

#### Complex Plugin Modification
```lua
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "bash", "html", "javascript", "json", "lua", "markdown", "python"
    })
  end
}
```

## Extras System

### Available Categories
- AI, Coding, Debug Adapter Protocol (DAP)
- Editor, Formatting, Language Support
- Linting, LSP, Testing, UI, Utilities
- VS Code integration

### Installation & Management
- Accessed via `:LazyExtras` command
- Provides visual interface for browsing and installing
- Modular approach to extending functionality
- Easy to enable/disable as needed

## Configuration Patterns

### Colorscheme Configuration
```lua
return {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "gruvbox",
  }
}
```

### LSP Server Configuration
```lua
servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic"
        }
      }
    }
  }
}
```

### Keymap Customization
```lua
keys = {
  { "<leader>fp", function() ... end, desc = "Find Plugin Files" },
  { "K", false }, -- Disable existing keymap
}
```

## Best Practices

### Configuration Conventions
- Use `opts` table for plugin configuration
- Leverage lazy.nvim's intelligent merging for `cmd`, `event`, `ft`, `keys`, `opts`, `dependencies`
- Follow LazyVim's naming patterns for consistency
- Provide sensible defaults while allowing customization

### Keymap Management
- Global keymaps in `lua/config/keymaps.lua`
- Plugin-specific keymaps through plugin configuration
- LSP keymaps automatically added on server attach
- Use `vim.keymap.del` to remove unwanted default keymaps

### Plugin Development
- Use lazy.nvim's plugin specification format
- Prefer configuration over code
- Leverage LazyVim's existing plugin ecosystem
- Follow modular and composable design patterns

## Default Settings

### Key Bindings
- Leader key: `<space>`
- Local leader key: `\`
- Extensive built-in keymaps using "which-key.nvim" for discoverability

### Performance Optimizations
- Selective RTP plugin disabling
- Lazy loading for most plugins
- Efficient startup configuration
- Minimal default plugin set with optional extras

### Plugin Management
- Automatic plugin updates enabled
- Version management: `version=false` recommended for active development
- Fallback colorschemes: "tokyonight", "habamax"
- Configuration merging via lazy.nvim

## Advanced Techniques

### Override Patterns
```lua
-- Completely override plugin configuration
return {
  "plugin-name",
  opts = { ... } -- Replaces default opts
}

-- Extend plugin configuration
return {
  "plugin-name",
  opts = function(_, opts)
    -- Modify opts table
    return opts
  end
}
```

### Recipe Patterns
- Supertab configuration for enhanced Tab behavior
- Transparency settings for themes
- LSP server-specific configurations
- Custom completion sources
- ESLint/Prettier integration for JavaScript/TypeScript

## Common Development Workflows

### Testing Configuration
```bash
# Test the configuration
nvim --clean -u init.lua

# Check plugin health
:LazyHealth

# Browse and install extras
:LazyExtras
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

This guide provides the foundation for understanding and working with LazyVim configurations. The system is designed to be both accessible to beginners and powerful enough for advanced users who need extensive customization capabilities.