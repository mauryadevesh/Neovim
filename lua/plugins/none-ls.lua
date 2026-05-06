return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,
    }

    if vim.fn.executable("eslint_d") == 1 then
      table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
    end

    null_ls.setup({
      sources = sources,
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({})
    end)
  end,
}
