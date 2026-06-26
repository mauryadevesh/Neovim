return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    local function set_dashboard_highlights()
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "AlphaHeaderGlow", { fg = "#bb9af7", bold = true })
      vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#7dcfff" })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#9ece6a" })
    end

    set_dashboard_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_dashboard_highlights,
    })

    dashboard.section.header.val = {
      [[ ]],
      [[ ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ██████╗  █████╗ ██████╗ ██╗   ██╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    ██████╔╝███████║██████╔╝ ╚████╔╝  ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╔══██╗██╔══██║██╔══██╗  ╚██╔╝   ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ██████╔╝██║  ██║██████╔╝   ██║    ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝    ╚═╝    ]],
      [[ ]],
      [[ ]],
    }
    dashboard.section.header.opts.hl = "AlphaHeader"

    dashboard.section.top_buttons.val = {
      dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("d", "󰙯  Toggle Discord RPC", "<cmd>CordToggle<CR>"),
      dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
    }
    dashboard.section.top_buttons.opts = { hl = "AlphaButtons", spacing = 1 }
    dashboard.section.bottom_buttons.val = {}
    dashboard.mru_sections = {}

    dashboard.section.footer = {
      type = "text",
      val = { "", " Ready to code" },
      opts = { hl = "AlphaFooter", position = "center" },
    }

    alpha.setup(dashboard.opts)
  end,
}
