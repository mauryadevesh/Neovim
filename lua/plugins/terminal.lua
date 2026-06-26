return {
   {
      "terminal-select",
      dir = vim.fn.stdpath("config"),
      virtual = true,
      lazy = false,
      config = function()

         local shells = {
            { name = "WSL",        cmd = "wsl.exe" },
            { name = "PowerShell", cmd = "powershell.exe" },
         }

         local default_shell = shells[1]

         local function open_term_in_tab(shell)
            local prev_shell = vim.o.shell
            vim.o.shell = shell.cmd
            vim.cmd("tabnew | terminal")
            vim.cmd("startinsert")
            vim.api.nvim_buf_set_var(0, "term_shell", shell.name)
            vim.o.shell = prev_shell
         end

         local function open_term_split(direction, shell)
            local file_dir = vim.fn.expand("%:p:h")
            local height = 12
            local prev_shell = vim.o.shell
            vim.o.shell = shell.cmd

            if direction == "l" then
               vim.cmd("topleft vsplit")
            elseif direction == "h" then
               vim.cmd("botright vsplit")
            elseif direction == "k" then
               vim.cmd("topleft " .. height .. "split")
            else
               vim.cmd("botright " .. height .. "split")
            end

            vim.cmd("lcd " .. file_dir)
            vim.cmd("terminal")
            vim.cmd("startinsert")
            vim.api.nvim_buf_set_var(0, "term_shell", shell.name)
            vim.o.shell = prev_shell
         end

         local function pick_shell(callback)
            local labels = {}
            for _, s in ipairs(shells) do
               table.insert(labels, s.name)
            end
            vim.ui.select(labels, { prompt = "Select terminal shell:" }, function(choice)
               if not choice then
                  return
               end
               for _, s in ipairs(shells) do
                  if s.name == choice then
                     callback(s)
                     return
                  end
               end
            end)
         end

         vim.keymap.set("n", "<leader>tn", function()
            pick_shell(function(shell)
               open_term_in_tab(shell)
            end)
         end, { desc = "New terminal tab (select shell)" })

         vim.keymap.set("n", "<leader>tw", function()
            open_term_in_tab(shells[1])
         end, { desc = "New terminal tab (WSL)" })

         vim.keymap.set("n", "<leader>tp", function()
            open_term_in_tab(shells[2])
         end, { desc = "New terminal tab (PowerShell)" })

         vim.keymap.set("n", "<leader>t", function()
            pick_shell(function(shell)
               open_term_split("j", shell)
            end)
         end, { desc = "Terminal split below (select shell)" })

         vim.keymap.set("n", "<leader>tj", function()
            pick_shell(function(shell)
               open_term_split("j", shell)
            end)
         end, { desc = "Terminal split below (select shell)" })

         vim.keymap.set("n", "<leader>tk", function()
            pick_shell(function(shell)
               open_term_split("k", shell)
            end)
         end, { desc = "Terminal split above (select shell)" })

         vim.keymap.set("n", "<leader>tl", function()
            pick_shell(function(shell)
               open_term_split("h", shell)
            end)
         end, { desc = "Terminal split right (select shell)" })

         vim.keymap.set("n", "<leader>th", function()
            pick_shell(function(shell)
               open_term_split("l", shell)
            end)
         end, { desc = "Terminal split left (select shell)" })

         vim.keymap.set("n", "<leader>ts", function()
            pick_shell(function(shell)
               default_shell = shell
               vim.notify("Default terminal shell set to: " .. shell.name, vim.log.levels.INFO)
            end)
         end, { desc = "Set default terminal shell" })

      end,
   },
}
