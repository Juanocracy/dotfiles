return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.ltex.setup({
        settings = {
          ltex = {
            language = "es-ES,en-US",
            disabledRules = {},
            dictionary = {
              ["es-ES"] = {},
              ["en-US"] = {},
            },
          },
        },
      })
    end,
  },
}
