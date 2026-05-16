return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      require("dap-go").setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      vim.keymap.set("n", "<leader>dt", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last Debug Session" })
    end,
  },
}
