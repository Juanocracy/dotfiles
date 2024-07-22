-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

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
