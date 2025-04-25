return {
  recommended = true,
  -- Copilot principal
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<C-l>", -- Cambiar tecla si prefieres algo más intuitivo
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  -- Acción personalizada para aceptar sugerencias
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      LazyVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          LazyVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
    end,
  },

  -- Configuración de lualine con integración de Copilot
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x,
        2,
        LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
          local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
          if #clients > 0 then
            local status = require("copilot.api").status.data.status
            return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
          end
        end)
      )
    end,
  },

  -- Fuente de completado para nvim-cmp
  vim.g.ai_cmp
      and {
        {
          "hrsh7th/nvim-cmp",
          optional = true,
          dependencies = {
            {
              "zbirenbaum/copilot-cmp",
              dependencies = { "hrsh7th/nvim-cmp" }, -- Asegura que nvim-cmp se cargue primero
              opts = function(_, opts)
                opts = opts or {} -- Asegura que `opts` sea una tabla válida
                opts.sources = opts.sources or {} -- Asegura que `opts.sources` sea una tabla válida
                table.insert(opts.sources, {
                  name = "copilot",
                  group_index = 1,
                  priority = 100,
                })
              end,
            },
          },
        },
      }
    or nil,
}
