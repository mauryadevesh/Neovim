return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
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
    end

    null_ls.setup({
      sources = sources,
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({})
    end)
  end,
}
