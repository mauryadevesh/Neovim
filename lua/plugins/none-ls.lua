return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
<<<<<<< HEAD
    local formatting = null_ls.builtins.formatting
    local sources = {
      formatting.stylua,
      formatting.black,
      formatting.isort,
    }

    if vim.fn.executable("prettierd") == 1 then
      table.insert(sources, formatting.prettierd)
    elseif vim.fn.executable("prettier") == 1 then
      table.insert(sources, formatting.prettier)
=======
    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
    }

    if vim.fn.executable("eslint_d") == 1 then
      table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
>>>>>>> fcaaf87955ef9c6a5422b9d4c4ec1d046e1a7f73
    end

    null_ls.setup({
      sources = sources,
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({})
    end)
  end,
}
