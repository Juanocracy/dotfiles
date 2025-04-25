return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- For completion
    "nvim-telescope/telescope.nvim", -- Picker
    "nvim-treesitter/nvim-treesitter", -- Syntax highlighting

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/ObsidianGit/Notes/",
      },
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    -- Configuración para generar IDs únicos con soporte para acentos.

    note_id_func = function(title)
      -- Genera un timestamp (segundos desde 1970-01-01).
      local timestamp = tostring(os.time())

      -- Mantén los acentos y transforma el título en un formato válido.
      local transformed_title = ""
      if title ~= nil then
        -- Reemplaza espacios con guiones, elimina caracteres no válidos y convierte a minúsculas.
        transformed_title = title
          :gsub(" ", "-") -- Reemplaza espacios con guiones.
          :gsub("[^%w%-áéíóúÁÉÍÓÚñÑ]", "") -- Permite letras, números, guiones y caracteres acentuados.
          :lower() -- Convierte todo a minúsculas.
      else
        -- Si no se proporciona un título, usa un valor predeterminado.
        transformed_title = "nota"
      end

      -- Combina el título transformado con el timestamp para un ID único.
      return transformed_title .. "-" .. timestamp
    end,
    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- Generate the file path using the ID.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    -- Optional, customize the metadata to include aliases with spaces.
    ---@param title string|?
    ---@return table
    note_metadata_func = function(title)
      local aliases = {}
      if title ~= nil then
        -- Use the original title with spaces as the alias.
        table.insert(aliases, title)
      end
      return {
        aliases = aliases,
      }
    end,

    -- Configuración de mappings.
    mappings = {
      -- Abre enlaces markdown o wiki con 'gf'.
      ["gf"] = {
        action = function()
          vim.cmd("ObsidianLinkOpen")
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = "Abrir enlace" },
      },
      -- Alterna checkboxes con '<leader>ch'.
      ["<leader>ch"] = {
        action = function()
          vim.cmd("ObsidianToggleCheckbox")
        end,
        opts = { buffer = true, desc = "Alternar checkbox" },
      },
      -- Acción inteligente: sigue enlaces o alterna checkboxes con '<cr>'.
      ["<cr>"] = {
        action = function()
          vim.cmd("ObsidianSmartAction")
        end,
        opts = { buffer = true, expr = true, desc = "Acción inteligente" },
      },
      -- Crear una nueva nota con '<leader>cn'.
      ["<leader>cn"] = {
        action = function()
          vim.cmd("ObsidianNew")
        end,
        opts = { noremap = true, silent = false, desc = "Crear nueva nota" },
      },
      -- Buscar una nota con '<leader>fn'.
      ["<leader>fn"] = {
        action = function()
          vim.cmd("ObsidianSearch")
        end,
        opts = { noremap = true, silent = true, desc = "Buscar nota" },
      },
      -- Agregar una imagen con '<leader>ai'.
      ["<leader>ai"] = {
        action = function()
          local clipboard = vim.fn.getreg("+") -- Obtiene la ruta de la imagen desde el portapapeles

          -- Verifica si el contenido del portapapeles es una ruta válida
          if not vim.fn.filereadable(clipboard) then
            vim.notify("El portapapeles no contiene una ruta válida a un archivo.", vim.log.levels.ERROR)
            return
          end

          local filename = vim.fn.fnamemodify(clipboard, ":t") -- Obtiene el nombre del archivo desde la ruta
          local target_path = "~/Documents/ObsidianGit/Notes/Excalidraw/Images/" .. filename

          -- Mueve la imagen desde el portapapeles al destino
          vim.fn.system({ "mv", clipboard, target_path })

          -- Inserta la referencia de la imagen en el archivo Markdown actual
          local markdown_reference = string.format("![%s](%s)", filename, target_path)
          vim.api.nvim_put({ markdown_reference }, "l", true, true)
        end,
      },
    },
  },
}
