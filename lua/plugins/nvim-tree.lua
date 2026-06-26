return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local api = require("nvim-tree.api")

      local function on_attach(bufnr)
        api.config.mappings.default_on_attach(bufnr)

        local function focus_current_folder()
          local node = api.tree.get_node_under_cursor()
          if node and node.type == "directory" then
            api.tree.change_root_to_node(node)
          end
        end

        vim.keymap.set("n", "<A-S-CR>", focus_current_folder, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          desc = "NvimTree: Focus selected folder",
        })
        vim.keymap.set("n", "<M-CR>", focus_current_folder, {
          buffer = bufnr,
          noremap = true,
          silent = true,
          desc = "NvimTree: Focus selected folder",
        })
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        view = {
          side = "right",
          width = 45,
          relativenumber = true,
        },
      })
    end,
  },
}
