return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2500,
      top_down = false,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.45)
      end,
      render = "wrapped-compact",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = false,
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      lsp = {
        progress = {
          enabled = true,
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        name_formatter = function(buf)
          if buf.id and vim.bo[buf.id].filetype == "alpha" then
            return "Home"
          end
          return buf.name
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
          },
        },
      },
      highlights = {
        fill = { bg = "#0b1220" },
        background = { fg = "#7f8ea3", bg = "#111827" },
        buffer_selected = { fg = "#f8f8f2", bg = "#2d2a55", bold = true, italic = false },
        separator = { fg = "#111827", bg = "#111827" },
        separator_selected = { fg = "#2d2a55", bg = "#2d2a55" },
        indicator_selected = { fg = "#ff79c6", bg = "#2d2a55" },
        modified_selected = { fg = "#f1fa8c", bg = "#2d2a55" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = {
        char = "|",
      },
      scope = {
        enabled = true,
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      easing = "quadratic",
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = true,
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    cond = vim.g.neovide == nil,
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      trailing_exponent = 2,
      hide_target_hack = false,
    },
    config = function(_, opts)
      require("smear_cursor").setup(opts)
      -- Disable smear cursor entirely when typing to eliminate lag/stutter
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          require("smear_cursor").enabled = false
        end,
      })
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          require("smear_cursor").enabled = true
        end,
      })
    end,
  },
}
