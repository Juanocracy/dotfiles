return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim", -- Para íconos
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      -- Formateador personalizado para Obsidian
      local obsidian_format = function(entry, item)
        if entry.source.name == "obsidian" then
          -- Limpiar el nombre para mostrar solo el nombre del archivo
          local filename = item.abbr:match("([^/]+)%.md$") or item.abbr
          item.abbr = filename

          -- Agregar ícono y etiqueta
          item.kind = "" -- Ícono de nota (puedes cambiarlo)
          item.menu = "[Obsidian]"
        end
        return item
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          {
            name = "obsidian",
            priority = 1000,
            -- Opción adicional para mostrar nombres limpios
            entry_filter = function(entry)
              return not entry.path:lower():find("trash")
            end,
          },
          { name = "nvim_lsp", priority = 900 },
          { name = "luasnip", priority = 800 },
          { name = "buffer", priority = 700 },
          { name = "path", priority = 600 },
        }),

        -- FORMATO PERSONALIZADO
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, item)
            -- Primero aplicamos el formato de Obsidian
            item = obsidian_format(entry, item)

            -- Luego aplicamos el formato general
            return lspkind.cmp_format({
              mode = "symbol_text",
              maxwidth = 50,
              menu = {
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
              },
            })(entry, item)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
