return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background", -- 'background', 'foreground' or 'virtual'
        enable_named_colors = true,
        enable_tailwind = true,
        enable_short_hex = true,
        virtual_symbol = "", -- Disable virtual symbol to avoid "twice" appearance
        virtual_symbol_position = "inline",
        exclude_filetypes = { "lazy", "mason", "TelescopePrompt" },
      })
    end,
  },
}
