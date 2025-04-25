return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Configuración de ltex
      lspconfig.ltex.setup({
        cmd = { "ltex-ls" },
        filetypes = { "markdown" },
        settings = {
          ltex = {
            language = "es-ES,en-US",
            disabledRules = {},
            dictionary = {
              ["es-ES"] = {}, -- Añade palabras personalizadas en español aquí
              ["en-US"] = {}, -- Añade palabras personalizadas en inglés aquí
            },
          },
        },
      })

      -- Configuración de jdtls para Java
      lspconfig.jdtls.setup({
        cmd = { "jdtls" },
        filetypes = { "java" },
        root_dir = function()
          return vim.fn.getcwd() -- Usa el directorio actual como raíz
        end,
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            maven = {
              downloadSources = true,
            },
          },
        },
      })
    end,
  },
}
