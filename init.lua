-- LEADER KEYS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.fn.chdir("C:/Users/maury/Documents")
require("keymaps")

vim.o.shell = "wsl.exe"
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
})
vim.keymap.set("n", "gl", vim.diagnostic.open_float)

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
vim.opt.wrap = false
vim.opt.sidescroll = 8
vim.opt.sidescrolloff = 15
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 12
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.showcmdloc = "last"
vim.opt.laststatus = 2
vim.opt.guicursor = "n-v-c:block-blinkwait300-blinkon200-blinkoff200,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff200,r-cr:ver25-blinkwait300-blinkon200-blinkoff200"

vim.api.nvim_create_autocmd({ "VimLeavePre", "VimLeave" }, {
  callback = function()
    io.write("\27[0 q")
    io.flush()
  end,
})

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
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.opt.cmdheight = 1
    vim.opt.showcmd = true
    vim.opt.showcmdloc = "last"
    vim.opt.laststatus = 2
  end,
})

-- KEYMAPS
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<A-w><A-w>", "<C-w>w", { noremap = true, silent = true })
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })
local function close_floating_window()
  local current_win = vim.api.nvim_get_current_win()
  local current_cfg = vim.api.nvim_win_get_config(current_win)
  if current_cfg.relative ~= "" then
    vim.api.nvim_win_close(current_win, true)
    return true
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      vim.api.nvim_win_close(win, true)
      return true
    end
  end

  return false
end

vim.keymap.set("n", "<Esc><Esc>", function()
  if close_floating_window() then
    return
  end
  vim.cmd("nohlsearch")
end, { noremap = true, silent = true, desc = "Close popup or clear search highlight" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { noremap = true, silent = true, desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<CR>", { noremap = true, silent = true, desc = "Force delete current buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })

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
