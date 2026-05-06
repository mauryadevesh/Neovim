return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      local function apply_line_number_colors()
        local bg = "none"
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7", bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#7aa2f7", bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#DA70D6", bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#bb9af7", bg = bg, bold = true })
      end

      local group = vim.api.nvim_create_augroup("RelativeLineNumberGlow", { clear = true })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = apply_line_number_colors,
      })

      apply_line_number_colors()
    end,
  },
}
