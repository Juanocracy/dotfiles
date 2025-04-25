return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- Configuración de nvim-dap
    dap.adapters.java = {
      type = "executable",
      command = "java",
      args = {
        "-jar",
        vim.fn.stdpath("data")
          .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
      },
    }

    dap.configurations.java = {
      {
        type = "java",
        request = "launch",
        name = "Debug (Launch)",
        mainClass = "${file}",
        projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
        cwd = vim.fn.getcwd(),
      },
    }
  end,

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      {
        "nvim-neotest/nvim-nio", -- Corrigido: ahora esto es parte de un subarray separado
        config = function()
          local dapui = require("dapui")
          dapui.setup({}) -- Inicializa la configuración de dap-ui

          local dap = require("dap")
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
    },
  },
}
