return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "obsidian" }, -- Obsidian aparece primero
          { name = "nvim_lsp" }, -- Segunda caja de autocompletado que me molestaba con blink
          { name = "luasnip" }, -- Snippets
          -- { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
