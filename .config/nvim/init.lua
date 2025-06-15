-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

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
return {
  "tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = function()
    return {
      transparent = true,
    }
  end,
}
