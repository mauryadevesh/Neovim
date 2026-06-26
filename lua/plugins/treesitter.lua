return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local config = {
        ensure_installed = {
          "c",
          "css",
          "html",
          "java",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            return ok and stats and stats.size > max_filesize
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      }

      local ok_configs, ts_configs = pcall(require, "nvim-treesitter.configs")
      if ok_configs then
        ts_configs.setup(config)
        return
      end

      local ok_new, ts = pcall(require, "nvim-treesitter")
      if ok_new and type(ts.setup) == "function" then
        ts.setup(config)
      end
    end,
  },
}
