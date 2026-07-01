vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.fn.chdir("C:/Users/maury/Documents")

require("keymaps")

-- OPTIONS
vim.opt.expandtab = true
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 12
vim.opt.sidescroll = 8
vim.opt.sidescrolloff = 15
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.showcmdloc = "last"
vim.opt.laststatus = 2
vim.opt.fillchars = { eob = " ", vert = " " }
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.guicursor = "n-v-c:block-blinkwait600-blinkon250-blinkoff350,i-ci-ve:ver25-CursorInsert-blinkwait0-blinkon0-blinkoff0,r-cr:block-blinkwait600-blinkon250-blinkoff350"

-- DIAGNOSTICS
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  underline = true,
  signs = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

-- NEOVIDE
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_vfx_mode = ""
end

-- LAZY
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
require("lazy").setup("plugins")

-- COLORSCHEME
vim.cmd.colorscheme("tokyonight")

-- HIGHLIGHTS
vim.api.nvim_set_hl(0, "CursorInsert", { fg = "#1e1e2e", bg = "#7a91b8", blend = 55 })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#6f8ebf", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#6f8ebf", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "NvimTreeLineNr", { fg = "#5eacd3", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#2a2d3a" })

local transparent_groups = {
  "Normal", "NormalNC", "EndOfBuffer", "LineNr", "SignColumn",
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
}
for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end

-- AUTOCMDS
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then return end
    vim.cmd("silent! lcd %:p:h")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeavePre", "VimLeave" }, {
  callback = function()
    io.write("\27[0 q")
    io.flush()
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    vim.opt.cmdheight = 1
    vim.opt.showcmd = true
    vim.opt.showcmdloc = "last"
    vim.opt.laststatus = 2
  end,
})

-- AUTOSAVE
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave", "FocusLost" }, {
  group = autosave_group,
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].buftype ~= "" then return end
    if not vim.bo[buf].modifiable or vim.bo[buf].readonly then return end
    if vim.api.nvim_buf_get_name(buf) == "" then return end
    if not vim.bo[buf].modified then return end
    vim.cmd("silent! write")
  end,
})

-- COMMANDS
vim.api.nvim_create_user_command("Home", function()
  vim.cmd("Alpha")
end, { desc = "Open the home dashboard" })

-- KEYMAPS
local map = vim.keymap.set

map("n", "mm", "<cmd>w<CR>", { silent = true })
map("n", "<leader>e", function()
  if vim.bo.buftype == "terminal" then
    local cwd_file = vim.fn.expand("~/.nvim_term_cwd")
    local term_dir = nil
    if vim.fn.filereadable(cwd_file) == 1 then
      local lines = vim.fn.readfile(cwd_file)
      if #lines > 0 and lines[1] ~= "" then
        term_dir = vim.fn.trim(lines[1])
      end
    end
    if term_dir and term_dir:match("^/") then
      local wsl_result = vim.fn.systemlist("wsl.exe wslpath -w " .. vim.fn.shellescape(term_dir))
      if vim.v.shell_error == 0 and #wsl_result > 0 then
        term_dir = vim.fn.trim(wsl_result[1])
      end
    end
    if not term_dir or term_dir == "" then
      term_dir = vim.fn.getcwd(0)
    end
    local tree_api = require("nvim-tree.api")
    tree_api.tree.open()
    tree_api.tree.change_root(term_dir)
  else
    vim.cmd("NvimTreeToggle")
  end
end, { silent = true, desc = "Toggle explorer (sync to terminal cwd)" })
map("n", "<A-w><A-w>", "<C-w>w", { noremap = true, silent = true })
map("i", "<M-BS>", "<C-w>", { noremap = true })
map("n", "gl", vim.diagnostic.open_float)

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

map("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true, desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<CR>", { silent = true, desc = "Force delete buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
map("n", "<leader>hh", "<cmd>Home<CR>", { silent = true, desc = "Home dashboard" })

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

map("n", "<Esc><Esc>", function()
  if close_floating_window() then return end
  vim.cmd("nohlsearch")
end, { noremap = true, silent = true, desc = "Close popup or clear highlight" })

-- RUN FILES
local function open_in_windows_browser()
  local file = vim.fn.expand("%:p")
  if file == "" then return end
  vim.fn.jobstart({ "cmd.exe", "/c", "start", "", file }, { detach = true })
end

map("n", "<leader>rh", function()
  vim.cmd("write")
  open_in_windows_browser()
end, { desc = "Open in browser" })
map("n", "<leader>rjn", ":w<CR>:!node %<CR>", { desc = "Run Node.js" })
map("n", "<leader>rpy", ":w<CR>:!python %<CR>", { desc = "Run Python" })
map("n", "<leader>rjj", ":w<CR>:!javac % && java %:r <CR>", { desc = "Run Java" })

map("n", "<leader>cj", "I//<Esc>", { desc = "Comment JS" })
map("n", "<leader>ch", "I<!-- <Esc>A --><Esc>", { desc = "Comment HTML" })
map("n", "<leader>cp", "I#<Esc>", { desc = "Comment Python" })
