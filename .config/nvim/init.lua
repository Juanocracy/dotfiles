-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.neotree")
require("plugins.obsidian")
require("plugins.render-markdown")
require("plugins.auto-save")
require("plugins.dap")

-- For enabling en and es spelling and grammar checking
vim.opt.spell = true
vim.opt.spelllang = { "en", "es" }

-- Establecer la regla visual solo para archivos Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.textwidth = 80
  end,
})

-- Configuración del tema Catppuccin
return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    transparent_background = true, -- Fondo transparente
    term_colors = true,
    styles = {
      comments = "italic",
      keywords = "bold",
    },
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      fzf = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
  vim.cmd.colorscheme("catppuccin"),
}
--return {
--  "tokyonight.nvim",
--  lazy = true,
--  priority = 1000,
--  opts = function()
--    return {
--      transparent = true,
--    }
--  end,
--}
