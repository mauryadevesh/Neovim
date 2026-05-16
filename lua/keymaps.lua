vim.keymap.set("n", "<leader>t", function()
    local file_dir = vim.fn.expand("%:p:h")

    vim.cmd("botright 12split")

    vim.cmd("lcd " .. file_dir)

    vim.cmd("terminal")

    vim.cmd("startinsert")
end)
