return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      local color_map = vim.api.nvim_get_color_map()
      local swatch_cache = {}

      for name, val in pairs(color_map) do
        local hex = string.format("#%06x", val)
        local hl_group = "CmpColor" .. hex:sub(2)
        if not swatch_cache[hl_group] then
          vim.api.nvim_set_hl(0, hl_group, { fg = hex, bg = hex })
          swatch_cache[hl_group] = true
        end
      end

      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      local function format_with_colors(entry, vim_item)
        local label = entry.completion_item.label or vim_item.abbr or ""
        local hex_match = label:match("#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]") or label:match("#[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]")
        local color_val

        if hex_match then
          local hex = hex_match
          if #hex == 4 then
            local r = hex:sub(2, 2)
            local g = hex:sub(3, 3)
            local b = hex:sub(4, 4)
            hex = "#" .. r .. r .. g .. g .. b .. b
          end
          color_val = tonumber(hex:sub(2), 16)
        else
          color_val = color_map[label] or color_map[label:lower()] or color_map[label:sub(1,1):upper() .. label:sub(2):lower()]
        end

        if entry.source.name == "color_names" or vim_item.kind == "Color" or entry:get_kind() == 16 or hex_match then
          if color_val then
            local hex = string.format("#%06x", color_val)
            local hl_group = "CmpColor" .. hex:sub(2)
            if not swatch_cache[hl_group] then
              vim.api.nvim_set_hl(0, hl_group, { fg = hex, bg = hex })
              swatch_cache[hl_group] = true
            end
            vim_item.kind = " ■ "
            vim_item.kind_hl_group = hl_group
            vim_item.menu = hex:upper()
            if entry.source.name == "color_names" then
              vim_item.abbr = label:lower()
            end
          elseif entry.source.name == "color_names" then
            vim_item.kind = " ■ "
            vim_item.menu = "[Color]"
          end
        else
          vim_item.kind = (kind_icons[vim_item.kind] or "") .. " " .. vim_item.kind
        end

        if not vim_item.menu or vim_item.menu == "" then
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
            color_names = "[Color]",
            color_functions = "[Func]",
            nvim_lsp_signature_help = "[Sig]",
          })[entry.source.name] or ""
        end

        local maxwidth = 40
        if vim_item.abbr and #vim_item.abbr > maxwidth then
          vim_item.abbr = vim_item.abbr:sub(1, maxwidth) .. "…"
        end

        return vim_item
      end

      local color_prioritizer = function(entry1, entry2)
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()
        local source1 = entry1.source.name
        local source2 = entry2.source.name
        local is_color1 = (source1 == "color_names" or kind1 == 16)
        local is_color2 = (source2 == "color_names" or kind2 == 16)

        if is_color1 and not is_color2 then return true end
        if not is_color1 and is_color2 then return false end

        if is_color1 and is_color2 then
          local label1 = entry1.completion_item.label:lower()
          local label2 = entry2.completion_item.label:lower()
          if label1 == label2 then return nil end
          return label1 < label2
        end

        return nil
      end

      local color_functions_source = {}
      function color_functions_source:is_available() return true end
      function color_functions_source:get_debug_name() return "color_functions" end
      function color_functions_source:complete(_, callback)
        callback({
          items = {
            { label = "rgb()", insertText = "rgb(${1:255}, ${2:255}, ${3:255})", insertTextFormat = 2, kind = 15, detail = "CSS RGB Color" },
            { label = "rgba()", insertText = "rgba(${1:255}, ${2:255}, ${3:255}, ${4:1})", insertTextFormat = 2, kind = 15, detail = "CSS RGBA Color" },
            { label = "hsl()", insertText = "hsl(${1:360}, ${2:100}%, ${3:50}%)", insertTextFormat = 2, kind = 15, detail = "CSS HSL Color" },
            { label = "hsla()", insertText = "hsla(${1:360}, ${2:100}%, ${3:50}%, ${4:1})", insertTextFormat = 2, kind = 15, detail = "CSS HSLA Color" },
            { label = "#HEX", insertText = "#${1:FFFFFF}", insertTextFormat = 2, kind = 15, detail = "Hex Color" },
          },
          isIncomplete = false,
        })
      end
      cmp.register_source("color_functions", color_functions_source)

      vim.keymap.set("n", "<leader>cc", function()
        vim.api.nvim_feedkeys("a", "n", true)
        vim.schedule(function()
          cmp.complete({
            config = {
              sources = {
                { name = "color_names", priority = 1000 },
                { name = "color_functions", priority = 500 },
                {
                  name = "nvim_lsp",
                  priority = 800,
                  entry_filter = function(entry)
                    return entry:get_kind() ~= 16
                  end,
                },
                { name = "luasnip", priority = 700 },
                { name = "buffer", priority = 400 },
              },
            },
          })
        end)
      end, { desc = "Trigger color completion" })

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        performance = {
          debounce = 50,
          throttle = 20,
          fetching_timeout = 300,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
            max_width = 60,
            max_height = 20,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            max_item_count = 30,
            entry_filter = function(entry)
              local client = entry.source:get_debug_name()
              if client and client:match("null%-ls") then
                return false
              end
              return true
            end,
          },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip", max_item_count = 10 },
          { name = "path" },
        }, {
          { name = "buffer", max_item_count = 8, keyword_length = 3 },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = format_with_colors,
        },
      })

      cmp.setup.filetype({
        "css", "scss", "sass", "less",
        "html", "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "astro", "vue", "svelte",
      }, {
        sorting = {
          priority_weight = 2,
          comparators = {
            color_prioritizer,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            max_item_count = 30,
            entry_filter = function(entry)
              return entry:get_kind() ~= 16
            end,
          },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip", max_item_count = 10 },
          { name = "path" },
        }, {
          { name = "buffer", max_item_count = 8, keyword_length = 3 },
        }),
      })
    end,
  },
}
