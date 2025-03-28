return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
}

--Can't get which key to work with nvim surround so I give up...
--[[
NVIM-SURROUND KEYBINDINGS REFERENCE

Normal Mode:
- ys{motion}{char} - Add surrounding around motion (e.g., ysiw" surrounds word with quotes)
- yss{char}        - Surround entire line
- yS{motion}{char} - Surround with newlines (opening char at end of line, closing on new line)
- ySS{char}        - Surround entire line with newlines
- ds{char}         - Delete surrounding characters
- cs{target}{char} - Change surrounding from target to char
- cS{target}{char} - Change surrounding with newlines

Visual Mode:
- S{char}          - Surround selected text
- gS{char}         - Surround selected text with newlines

Common targets for {char}:
- Brackets: ( ) [ ] { } < >
- Quotes: ' " `
- Special: t (HTML tags), f (function call)

Pair behavior:
- Use closing brackets for no spacing: ys{motion})  → (text)
- Use opening brackets for spacing:    ys{motion}(  → ( text )

Examples:
- ysiw)  - Surround word with parentheses without spaces: (word)
- ysiw(  - Surround word with parentheses with spaces: ( word )
- yssB   - Surround line with curly braces (no spacing)
- ds"    - Delete surrounding quotes
- cs'"   - Change surrounding single quotes to double quotes
- cs{(   - Change surrounding curly braces to parentheses with spaces
- ys2aw* - Surround 2 words with asterisks
- ysiw<p> - Surround word with HTML paragraph tags
]]
