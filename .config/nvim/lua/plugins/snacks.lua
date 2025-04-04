return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right", -- Cambia el explorador al lado derecho
            },
          },
        },
      },
    },

    image = {
      doc = {
        enabled = true,
        inline = true, -- Renderizado inline
        float = false, -- Sin ventanas flotantes
        -- max_height = nil,
      },
      math = {
        enabled = true, -- enable math expression rendering
        -- in the templates below, `${header}` comes from any section in your document,
        -- between a start/end header comment. Comment syntax is language-specific.
        -- * start comment: `// snacks: header start`
        -- * end comment:   `// snacks: header end`
      },
    },
  },

  -- Otras configuraciones relevantes para snacks.nvim
  bigfile = { enabled = true },
  dashboard = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}
