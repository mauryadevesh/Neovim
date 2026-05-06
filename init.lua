-- LEADER KEYS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("keymaps")

vim.cmd("set expandtab")
vim.cmd("set tabstop=3")
vim.cmd("set softtabstop=3")
vim.cmd("set shiftwidth=3")
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
})
-- TELESCOPE KEYMAPS
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- DISABLE NETRW (required for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 12
vim.api.nvim_set_hl(0, "NvimTreeLineNr", {
  fg = "#5eacd3",
  bold = true
})

vim.api.nvim_set_hl(0, "NvimTreeCursorLine", {
  bg = "#2a2d3a"
})



-- CLEAN BACKGROUND
vim.opt.fillchars = { eob = " ", vert = " " }

-- LAZY
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require("lazy").setup("plugins")  -- ONLY ONE CALL

-- KEYMAPS
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<A-w><A-w>", "<C-w>w", { noremap = true, silent = true })
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- AUTO CD INTO FILE DIR
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("silent! lcd %:p:h")
  end,
})

-- COLORS
vim.cmd.colorscheme("tokyonight")
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#7aa2f7", bg = "#1e1e2e" })

-- TRANSPARENCY
local transparent_groups = {
  "Normal", "NormalNC", "EndOfBuffer", "LineNr", "SignColumn",
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end

-- RUN FILES
vim.keymap.set("n", "<leader>rh", ":w<CR>:!start %<CR>")
vim.keymap.set("n", "<leader>rjn", ":w<CR>:!node %<CR>")
vim.keymap.set("n", "<leader>rpy", ":w<CR>:!python %<CR>")
vim.keymap.set("n", "<leader>rjj", ":w<CR>:!javac % && java %:r <CR>")

-- COMMENT SHORTCUTS
vim.keymap.set("n", "<leader>cj", "I//<Esc>")
vim.keymap.set("n", "<leader>ch", "I<!-- <Esc>A --><Esc>")
vim.keymap.set("n", "<leader>cp", "I#<Esc>")
