return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- si usas el suite mini.nvim
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- si usas plugins mini independientes
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- si prefieres nvim-web-devicons
  opts = {
    enabled = true,
    max_file_size = 10.0,
    debounce = 100,
    preset = "none",
    log_level = "error",
    log_runtime = false,
    file_types = { "markdown" },
    injections = {
      gitcommit = {
        enabled = true,
        query = [[
          ((message) @injection.content
            (#set! injection.combined)
            (#set! injection.include-children)
            (#set! injection.language "markdown"))
        ]],
      },
    },
    render_modes = true,
    anti_conceal = {
      enabled = true,
      ignore = { code_background = true, sign = true },
      above = 0,
      below = 0,
    },
    padding = { highlight = "Normal" },
    latex = {
      enabled = false,
      converter = "latex2text",
      highlight = "RenderMarkdownMath",
      top_pad = 0,
      bottom_pad = 0,
    },
    on = { attach = function() end },
    heading = {
      enabled = true,
      sign = true,
      position = "overlay",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      signs = { "󰫎 " },
      width = "block",
      left_margin = 0,
      left_pad = 2,
      right_pad = 4,
      min_width = 0,
      border = true,
      border_virtual = false,
      border_prefix = false,
      above = "▂",
      below = "▔",
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    paragraph = {
      enabled = true,
      left_margin = 0,
      min_width = 0,
    },
    code = {
      enabled = true,
      sign = true,
      style = "full",
      position = "left",
      language_pad = 0,
      language_name = true,
      disable_background = { "diff" },
      width = "block",
      left_margin = 0,
      left_pad = 0.015,
      right_pad = 0.02,
      min_width = 0,
      border = "thin",
      above = "▂",
      below = "▔",
      highlight = "RenderMarkdownCode",
      highlight_inline = "RenderMarkdownCodeInline",
      highlight_language = nil,
    },
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
      highlight = "RenderMarkdownDash",
    },
    bullet = {
      enabled = true,
      render_modes = true,
      icons = { "●", "○", "◆", "◇" },
      ordered_icons = function(ctx)
        local value = vim.trim(ctx.value)
        local index = tonumber(value:sub(1, #value - 1))
        return string.format("%d.", index > 1 and index or ctx.index)
      end,
      left_pad = 0,
      right_pad = 1,
      highlight = "RenderMarkdownBullet",
    },
    checkbox = {
      enabled = true,
      render_modes = false,
      unchecked = {
        icon = "✘ ",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = nil,
      },
      checked = {
        icon = "✔ ",
        highlight = "RenderMarkdownChecked",
        scope_highlight = "@markup.strikethrough",
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        important = { raw = "[~]", rendered = "󰓎 ", highlight = "DiagnosticWarn" },
      },
    },

    quote = {
      enabled = true,
      icon = "▌",
      repeat_linebreak = true,
      highlight = "RenderMarkdownQuote",
    },
    pipe_table = {
      enabled = true,
      preset = "none",
      style = "full",
      cell = "padded",
      padding = 1,
      min_width = 0,
      border = { "┌", "┬", "┐", "├", "┼", "┤", "└", "┴", "┘", "│", "─" },
      alignment_indicator = "━",
      head = "RenderMarkdownTableHead",
      row = "RenderMarkdownTableRow",
      filler = "RenderMarkdownTableFill",
    },
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
      summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
      tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
      info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
      todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
      hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
      success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
      check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
      done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
      question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
      help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
      faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
      attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
      failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
      fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
      missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
      danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
      error = { raw = "[!ERROR]", rendered = "󱐌 Error", highlight = "RenderMarkdownError" },
      bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
      example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
      quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
      cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
    },
    link = {
      -- Turn on / off inline link icon rendering
      enabled = true,
      -- Inlined with 'image' elements
      image = "󰥶 ",
      -- Inlined with 'email_autolink' elements
      email = "󰀓 ",
      -- Fallback icon for 'inline_link' elements
      hyperlink = "󰌹 ",
      -- Applies to the fallback inlined icon
      highlight = "RenderMarkdownLink",
      -- Applies to WikiLink elements
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      -- Define custom destination patterns so icons can quickly inform you of what a link
      -- contains. Applies to 'inline_link' and wikilink nodes.
      -- Can specify as many additional values as you like following the 'web' pattern below
      --   The key in this case 'web' is for healthcheck and to allow users to change its values
      --   'pattern':   Matched against the destination text see :h lua-pattern
      --   'icon':      Gets inlined before the link text
      --   'highlight': Highlight for the 'icon'
      custom = {
        web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
      },
    },
    sign = {
      -- Turn on / off sign rendering
      enabled = true,
      -- Applies to background of sign text
      highlight = "RenderMarkdownSign",
    },
    -- Mimic org-indent-mode behavior by indenting everything under a heading based on the
    -- level of the heading. Indenting starts from level 2 headings onward.
    indent = {
      -- Turn on / off org-indent-mode
      enabled = true,
      -- Amount of additional padding added for each heading level
      per_level = 2,
      -- Heading levels <= this value will not be indented
      -- Use 0 to begin indenting from the very first level
      skip_level = 6,
      -- Do not indent heading titles, only the body
      skip_heading = false,
    },
    -- Window options to use that change between rendered and raw view
    win_options = {
      -- See :h 'conceallevel'
      conceallevel = {
        -- Used when not being rendered, get user setting
        default = vim.api.nvim_get_option_value("conceallevel", {}),
        -- Used when being rendered, concealed text is completely hidden
        rendered = 3,
      },
      -- See :h 'concealcursor'
      concealcursor = {
        -- Used when not being rendered, get user setting
        default = vim.api.nvim_get_option_value("concealcursor", {}),
        -- Used when being rendered, disable concealing text in all modes
        rendered = "",
      },
    },
    -- More granular configuration mechanism, allows different aspects of buffers
    -- to have their own behavior. Values default to the top level configuration
    -- if no override is provided. Supports the following fields:
    --   enabled, max_file_size, debounce, render_modes, anti_conceal, padding,
    --   heading, paragraph, code, dash, bullet, checkbox, quote, pipe_table,
    --   callout, link, sign, indent, win_options
    overrides = {
      -- Overrides for different buftypes, see :h 'buftype'
      buftype = {
        nofile = {
          padding = { highlight = "NormalFloat" },
          sign = { enabled = false },
        },
      },
      -- Overrides for different filetypes, see :h 'filetype'
      filetype = {},
    },
    -- Mapping from treesitter language to user defined handlers
    -- See 'Custom Handlers' document for more info
    custom_handlers = {},
  },
}
