return {
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true, -- Inicia el auto guardado cuando se carga el plugin
        execution_message = {
          message = function()
            return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
          end,
          dim = 0.18, -- Atenúa el color del mensaje
          cleaning_interval = 1250, -- Limpia el área de mensajes después de mostrar el mensaje
        },
        trigger_events = { "InsertLeave", "TextChanged" }, -- Eventos que desencadenan el auto guardado
        debounce_delay = 135, -- Guarda el archivo como máximo cada 135 milisegundos
      })
    end,
  },
}
