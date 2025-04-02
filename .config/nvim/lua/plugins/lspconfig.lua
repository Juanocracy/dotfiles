return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.ltex.setup({
        cmd = { "ltex-ls" }, -- Asegúrate de que el ejecutable esté en tu PATH
        filetypes = { "markdown", "tex", "txt" }, -- Define los tipos de archivo soportados
        settings = {
          ltex = {
            language = "es-ES,en-US", -- Idiomas a utilizar
            disabledRules = {
              ["es-ES"] = {}, -- Aquí puedes desactivar reglas específicas
              ["en-US"] = {}, -- Ejemplo: {"WHITESPACE"}
            },
            dictionary = {
              ["es-ES"] = {}, -- Palabras personalizadas en español
              ["en-US"] = {}, -- Palabras personalizadas en inglés
            },
            hiddenFalsePositives = {
              ["es-ES"] = {}, -- Falsos positivos ocultos
              ["en-US"] = {},
            },
          },
        },
      })
    end,
  },
}
