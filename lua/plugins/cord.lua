return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    cmd = { "Cord", "CordToggle" },
    init = function()
      vim.g.cord_defer_startup = true
    end,
    opts = {
      text = {
        workspace = function(opts)
          local buf = vim.api.nvim_buf_get_name(0)
          if buf == "" then
            return opts.workspace and ("In " .. opts.workspace) or nil
          end

          local dir = vim.fn.fnamemodify(buf, ":h:t")
          if dir == "" then
            return opts.workspace and ("In " .. opts.workspace) or nil
          end

          return "In " .. dir
        end,
      },
      advanced = {
        discord = {
          reconnect = {
            enabled = true,
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.cord_user_opts = opts
      vim.api.nvim_create_user_command("CordToggle", function()
        local cord = require("cord.server")
        if not cord.manager then
          require("cord").setup(vim.g.cord_user_opts or {})
          return
        end
        require("cord.api.command").toggle_presence()
      end, {})
    end,
  },
}
