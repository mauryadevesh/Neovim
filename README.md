# Neovim
This is my Neovim Configurations. please have a look if u like it and lemme know your response.
=======
# Neovim Configuration (Windows-first)

A fast, practical, and feature-rich Neovim setup focused on coding, notes, markdown workflows, and multi-language development.

This config uses **lazy.nvim** for plugin management, **Mason + nvim-lspconfig** for LSP, **Conform** for formatting, **Treesitter** for syntax/structure, and **Telescope + Yazi** for navigation.

---

## Features

- **Plugin management:** `lazy.nvim`
- **LSP setup:** `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`
- **Autocomplete/snippets:** `blink.cmp`, `LuaSnip`, `cmp-latex-symbols`
- **Formatting on save:** `conform.nvim` (with per-language formatters)
- **Syntax & text objects:** `nvim-treesitter`, `nvim-treesitter-context`, treesitter textobjects
- **Search/navigation:** `telescope.nvim` (+ zoxide + ui-select), `yazi.nvim`
- **UI/UX:** `alpha-nvim` dashboard, `lualine`, `which-key`, transparent mode
- **Writing/notes workflow:** markdown preview, markdown math, image.nvim, Obsidian helper command, markdown todo toggles
- **Debugging:** `nvim-dap` + `nvim-dap-ui` (configured for codelldb/C)
- **Extras:** zen mode, comments, tabout, csv viewer, tmux navigation, screenkey
