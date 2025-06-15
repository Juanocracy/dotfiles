return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/ObsidianGit/Notes/",
      },
    },
    note_id_func = function(title)
      local timestamp = tostring(os.time())
      local transformed_title = title and title:gsub(" ", "-"):gsub("[^%w%-áéíóúÁÉÍÓÚñÑ]", ""):lower()
        or "nota"
      return transformed_title .. "-" .. timestamp
    end,
    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,
    note_metadata_func = function(title)
      local aliases = {}
      if title ~= nil then
        table.insert(aliases, title)
      end
      return {
        aliases = aliases,
      }
    end,
    attachments = {
      img_folder = "/home/juan/Documents/ObsidianGit/Excalidraw/Images/",
    },
    mappings = {
      ["gf"] = {
        action = function()
          vim.cmd("ObsidianFollowLink") -- Comando actualizado
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = "Abrir enlace" },
      },
      ["<leader>ch"] = {
        action = function()
          vim.cmd("ObsidianToggleCheckbox")
        end,
        opts = { buffer = true, desc = "Alternar checkbox" },
      },
      -- ACCIÓN CORREGIDA PARA ENTER
      ["<cr>"] = {
        action = function()
          local obsidian_util = require("obsidian.util")
          if obsidian_util.cursor_on_markdown_link() then
            vim.cmd("ObsidianFollowLink")
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
          end
        end,
        opts = { buffer = true, expr = true, desc = "Acción inteligente" },
      },
      ["<leader>cn"] = {
        action = function()
          vim.cmd("ObsidianNew")
        end,
        opts = { noremap = true, silent = false, desc = "Crear nueva nota" },
      },
      ["<leader>fn"] = {
        action = function()
          vim.cmd("ObsidianSearch")
        end,
        opts = { noremap = true, silent = true, desc = "Buscar nota" },
      },
      ["<leader>af"] = {
        action = function()
          local clipboard = vim.fn.getreg("+")
          if not vim.fn.filereadable(clipboard) then
            vim.notify("El portapapeles no contiene una ruta válida a un archivo.", vim.log.levels.ERROR)
            return
          end
          local filename = vim.fn.fnamemodify(clipboard, ":t")
          local target_path = "~/Documents/ObsidianGit/Notes/Excalidraw/Images/" .. filename
          vim.fn.system({ "mv", clipboard, target_path })
          local markdown_reference = string.format("![%s](%s)", filename, target_path)
          vim.api.nvim_put({ markdown_reference }, "l", true, true)
        end,
      },
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Filtrar notas de .trash y registrar en cmp
    vim.schedule(function()
      if package.loaded["cmp"] then
        local cmp = require("cmp")
        local obsidian = require("obsidian")

        -- Crear una fuente filtrada
        local source = obsidian.source.new()
        local original_complete = source.complete

        source.complete = function(_, params, callback)
          original_complete(_, params, function(items)
            if not items then
              return callback(items)
            end

            local filtered = {}
            for _, item in ipairs(items) do
              -- Excluir notas en .trash
              if not item.abbr:lower():find("trash") then
                table.insert(filtered, item)
              end
            end
            callback(filtered)
          end)
        end

        cmp.register_source("obsidian", source)
      end
    end)

    -- Crear comando alternativo para compatibilidad
    vim.api.nvim_create_user_command("ObsidianSmartAction", function()
      local obsidian_util = require("obsidian.util")
      if obsidian_util.cursor_on_markdown_link() then
        vim.cmd("ObsidianFollowLink")
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
      end
    end, {})
  end,
}
