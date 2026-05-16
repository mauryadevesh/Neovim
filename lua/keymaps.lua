<<<<<<< HEAD
vim.keymap.set("n", "<leader>t", function()
    local file_dir = vim.fn.expand("%:p:h")

    vim.cmd("botright 12split")

    vim.cmd("lcd " .. file_dir)

    vim.cmd("terminal")

    vim.cmd("startinsert")
end)
=======
vim.keymap.set("n", "<leader>t", ":botright 12split | terminal<CR>")
>>>>>>> fcaaf87955ef9c6a5422b9d4c4ec1d046e1a7f73
