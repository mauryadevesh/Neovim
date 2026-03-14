vim.cmd("cd C:/Users/maury/Onedrive/Documents")


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- LEADER KEYS (must be first)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.keymap.set("n", "<leader>t", ":botright 12split | terminal<CR>")

-- DELETE WORD WITH ALT+BACKSPACE
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })

-- CLEAR SEARCH HIGHLIGHT
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- LOAD YOUR MODULES
require("options")
require("keymaps")
require("telescope").setup({})


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
    relativenumber = true
  },
   update_focused_file = {
   enable = true,
   update_root = true
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true
      }
    }
  },
  filters = {
    dotfiles = false
  }
})
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
