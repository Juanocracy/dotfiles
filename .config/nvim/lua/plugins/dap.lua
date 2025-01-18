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
        projectName = "YourProjectName",
        cwd = vim.fn.getcwd(),
      },
    }
  end,
}
