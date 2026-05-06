return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ok_new, ts = pcall(require, "nvim-treesitter")
      if ok_new and type(ts.setup) == "function" then
        ts.setup({})
        return
      end

      local ok_old, ts_configs = pcall(require, "nvim-treesitter.configs")
      if not ok_old then
        return
      end

      ts_configs.setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
        },
        auto_install = false,
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            return ok_stat and stats and stats.size > max_filesize
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
