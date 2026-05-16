<<<<<<< HEAD
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

---

## Installed Themes

Default startup theme is:

- `custom` (`vim.cmd.colorscheme("custom")`)

Also installed:

- `newsprint.vim`
- `nord.nvim`
- `lackluster.nvim`
- `zenesque.vim`
- `fogbell.vim`
- `iceberg.nvim`
- `makurai-nvim`
- `gruvbox.nvim`
- `Zenburn`
- `base16-nvim`
- `gruvbox-material`
- `gruber-darker.nvim`
- `zenbones.nvim`
- `vague.nvim`

Extra local colors in this repo:

- `colors/custom.vim`
- `colors/dosbox.vim`
- `colors/dosbox-black.vim`

---

## Requirements (Windows)

### Core

1. **Neovim** `>= 0.10`
2. **Git**
3. **PowerShell** (already used in config on Windows)

### Recommended CLI tools

1. `ripgrep` (used by Telescope file finding)
2. `fd` (optional but useful for searching)
3. `make` or build tools (needed by `telescope-fzf-native`)
4. `Node.js` + `yarn` (needed by markdown preview plugin build step)
5. `luarocks` (needed by `image.nvim` dependency `magick`)
6. `yazi` (for integrated file manager workflow)

### Optional (language/debug tooling)

- `codelldb` for DAP C/C++ debugging
- language servers and formatters for your stack (Mason installs many automatically, but some tools still need system binaries)

---

## Installation (Windows)

> Neovim config path on Windows:
> `C:\Users\<username>\AppData\Local\nvim`
> (same as `%LOCALAPPDATA%\nvim`)

### 1. Backup existing config

```powershell
if (Test-Path "$env:LOCALAPPDATA\nvim") {
  Rename-Item "$env:LOCALAPPDATA\nvim" "nvim.backup.$((Get-Date).ToString('yyyyMMdd-HHmmss'))"
}
```

### 2. Clone this repo into Neovim config path

```powershell
git clone <YOUR_REPO_URL> "$env:LOCALAPPDATA\nvim"
```

### 3. Start Neovim

```powershell
nvim
```

On first launch, `lazy.nvim` installs plugins automatically.

### 4. Run health checks

Inside Neovim:

```vim
:checkhealth
```

---

## First Run Notes

- Treesitter parsers install/update automatically (`:TSUpdate` configured).
- Mason installs configured LSP servers from `lua/plugins/lspconfig.lua`.
- Markdown preview plugin runs `cd app && yarn install` during build.
- If Telescope FZF native fails on Windows, install build tools and run:

```vim
:Lazy build telescope-fzf-native.nvim
```

---

## How to Run / Daily Usage

### Start

```powershell
nvim
```

### Useful built-in mappings

- `<Space>` = leader
- `<C-h/j/k/l>`: move across windows
- `<leader>vs` / `<leader>hs`: vertical/horizontal split
- `<leader>wc`: close window
- `<leader>jk`: Telescope find files
- `<leader>fg`: Telescope live grep
- `<leader>fd`: diagnostics picker
- `<leader>fz`: zoxide list
- `<leader>n`: open Yazi at current file
- `<leader>cw`: open Yazi in cwd
- `<leader>zz`: Zen mode
- `K`, `gd`, `gr`, `<leader>ca`: core LSP actions
- `<leader>e`, `[e`, `]e`: diagnostics float/navigation

---

## Language Support Snapshot

This config is set up for many ecosystems (via Mason/LSP + formatters), including:

- Lua, JS/TS, HTML/CSS, Astro, Tailwind/emmet
- Go, Rust, C/C++, Python
- SQL, YAML, JSON, Markdown, LaTeX

Exact server/formatter lists are in:

- `lua/plugins/lspconfig.lua`
- `lua/plugins/conform.lua`
- `lua/plugins/treesitter.lua`

---

## Custom Commands

- `:Setwd` -> set cwd to current file’s directory
- `:OpenInObsidian` -> open current markdown file in Obsidian workflow
- `:FormatDisable` / `:FormatEnable` -> toggle autoformat behavior

---

## Project Structure (important files)

```text
init.lua
lua/
  options.lua
  keymaps.lua
  autocmds.lua
  lazynvim.lua
  plugins/
  mappings/
colors/
assets/
```
---

## License

Use and modify freely for personal workflow. Add your preferred license in this repository if you want formal terms.
>>>>>>> fcaaf87955ef9c6a5422b9d4c4ec1d046e1a7f73
