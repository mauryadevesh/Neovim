return {
   {
      "echasnovski/mini.ai",
      version = false,
      event = "VeryLazy",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
         local ai = require("mini.ai")
         ai.setup({
            n_lines = 500,
            custom_textobjects = {
               F = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
               c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
               o = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
               l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
            },
            mappings = {
               around = "a",
               inside = "i",
               around_next = "an",
               inside_next = "in",
               around_last = "al",
               inside_last = "il",
               goto_left = "g[",
               goto_right = "g]",
            },
         })
      end,
   },
}
