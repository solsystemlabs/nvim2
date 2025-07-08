# LazyVim Default Keymaps Reference

This file contains the default LazyVim keymaps for reference when customizing configurations.

## Key Root/CWD Patterns

LazyVim uses a consistent pattern for keybindings that differentiate between root directory and current working directory:

### File Operations
- `<leader>ff` - Find Files (Root Dir)
- `<leader>fF` - Find Files (cwd)
- `<leader>fr` - Recent Files (Root Dir)  
- `<leader>fR` - Recent Files (cwd)

### Search Operations
- `<leader>sg` - Grep (Root Dir)
- `<leader>sG` - Grep (cwd)
- `<leader>sw` - Visual selection or word (Root Dir)
- `<leader>sW` - Visual selection or word (cwd)

### Explorer Operations
- `<leader>e` - Explorer Snacks (Root Dir)
- `<leader>E` - Explorer Snacks (cwd)

### Git Operations
- `<leader>gg` - GitUi (Root Dir)
- `<leader>gG` - GitUi (cwd)

## Pattern Convention
- **lowercase** = Root Directory (project root, typically where .git is located)
- **uppercase** = Current Working Directory (the directory you're currently in)

## Configuration Notes
This configuration swaps the default pattern to make lowercase work with current working directory and uppercase work with root directory, since cwd is used more frequently in daily workflows.

---

*Generated from LazyVim keymaps documentation: https://www.lazyvim.org/keymaps*