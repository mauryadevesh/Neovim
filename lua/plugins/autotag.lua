return {
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function()
      require("nvim-ts-autotag").setup()
      
      -- Auto-close tags on > keypress with cursor between tags
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {"html", "xml", "php", "jsx", "tsx", "vue"},
        callback = function(args)
          vim.keymap.set("i", ">", function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local before_cursor = line:sub(1, col)
            
            if before_cursor:match("<[^/>]+$") then
              local tag = before_cursor:match("<([a-zA-Z][a-zA-Z0-9]*)")
              if tag and not vim.tbl_contains({"br", "hr", "img", "input", "meta", "link"}, tag) then
                local closing_tag = "</" .. tag .. ">"
                vim.schedule(function()
                  local current_row = vim.api.nvim_win_get_cursor(0)[1]
                  local new_col = col + 1
                  vim.api.nvim_win_set_cursor(0, {current_row, new_col})
                end)
                return ">" .. closing_tag
              end
            end
            return ">"
          end, { expr = true, noremap = true, buffer = true })
        end,
      })
    end,
  },
}
