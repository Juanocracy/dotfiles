-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.neotree")
require("plugins.obsidian")
require("plugins.render-markdown")
require("plugins.auto-save")

-- For enabling en and es spelling and grammar checking
vim.opt.spell = true
vim.opt.spelllang = { "en", "es" }

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
