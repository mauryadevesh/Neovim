-- LEADER KEYS (must be first)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("cd C:/Users/maury/Onedrive/Documents")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- TRUE COLOR SUPPORT
vim.opt.termguicolors = true

-- LAZY.NVIM RUNTIME PATH
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- LOAD PLUGINS
require("lazy").setup("plugins")

-- BASIC OPTIONS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- TRANSPARENT BACKGROUND
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-- space + e for exiting a file 
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")


-- getting relative number in teh nvim
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"

-- TERMINAL SPLIT
--vim.keymap.set("n", "<leader>t", ":botright 12split | terminal<CR>")

-- DELETE WORD WITH ALT+BACKSPACE
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })

-- CLEAR SEARCH HIGHLIGHT
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- LOAD YOUR MODULES
require("options")
require("keymaps")
require("telescope").setup({})
require("lazy").setup({
	{
		"ThePrimeagen/vim-be-good"
	}
})

require("tokyonight").setup({
  style = "storm",
  transparent = true
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("silent! lcd %:p:h")
  end
})


-- COLORSCHEME
vim.cmd.colorscheme("tokyonight")

require("nvim-tree").setup({
  view = {
    side = "right",
    width = 30,
    relativenumber = true,
  },

  update_focused_file = {
    enable = true,
    update_root = true,
  },

  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
      },
    },
  },

  filters = {
    dotfiles = false,
  },

  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

require("lazy").setup("plugins")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- override open action
    vim.keymap.set("n", "l", function()
      api.node.open.edit()
      vim.cmd("normal! zz")
    end, opts("Open and center"))
  end,
})

vim.opt.scrolloff = 12

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })



vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#4c5b7a" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#4c5b7a" })
vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#3a4560" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3a4560" })
vim.api.nvim_set_hl(0, "NvimTreeFileName", { fg = "#5c6f95" })



-- RUN FILES
vim.keymap.set("n", "<leader>rh", ":w<CR>:!start %<CR>", { desc = "Run HTML" })
vim.keymap.set("n", "<leader>rj", ":w<CR>:!node %<CR>", { desc = "Run JavaScript" })
vim.keymap.set("n", "<leader>rp", ":w<CR>:botright 12split | terminal python %<CR>")



vim.keymap.set("n", "<leader>cj", "I//<Esc>", { desc = "Comment JS line" })
vim.keymap.set("n", "<leader>ch", "I<!-- <Esc>A --><Esc>", { desc = "Comment HTML line" })
vim.keymap.set("n", "<leader>cp", "I#<Esc>", { desc = "Comment Python line" })
