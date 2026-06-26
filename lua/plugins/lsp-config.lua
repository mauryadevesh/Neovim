return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "clangd", "cssls", "html", "emmet_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        if client.name == "html" or client.name == "cssls" or client.name == "ts_ls" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.config("pyright", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      })

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--query-driver=C:/msys64/mingw64/bin/*,C:/mingw64/bin/*,C:/Program Files/LLVM/bin/*",
        },
        init_options = {
          fallbackFlags = { "-std=c17" },
        },
      })

      vim.lsp.config("cssls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          css = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true },
        },
      })

      vim.lsp.config("html", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue", "svelte" },
      })

      vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "clangd", "cssls", "html", "emmet_ls" })

      local map = vim.keymap.set
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      map("n", "gr", vim.lsp.buf.references, { desc = "References" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type definition" })
      map("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Signature help" })
    end,
  },
}
