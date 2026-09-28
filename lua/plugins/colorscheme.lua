-- Catppuccin Macchiato colorscheme configuration for Lazy.nvim

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- Load during startup since it's the main colorscheme
  priority = 1000, -- Load before other plugins
  config = function()
    require("catppuccin").setup({
      -- Unlisted options (styles, lsp_styles, dim_inactive, ...) use catppuccin's defaults
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      custom_highlights = function(colors)
        return {
          -- Disable italic for imported module/library names in Python
          ["@variable.member.python"] = { fg = colors.teal, style = {} },
          ["@module.python"] = { fg = colors.teal, style = {} },
          -- Disable italic for all Go syntax except comments
          ["@function.go"] = { fg = colors.blue, style = {} },
          ["@function.call.go"] = { fg = colors.blue, style = {} },
          ["@function.builtin.go"] = { fg = colors.blue, style = {} },
          ["@keyword.go"] = { style = {} },
          ["@keyword.conditional.go"] = { style = {} },
          ["@keyword.repeat.go"] = { style = {} },
          ["@type.go"] = { style = {} },
          ["@variable.go"] = { style = {} },
          ["@property.go"] = { style = {} },
          ["@string.go"] = { style = {} },
          ["@number.go"] = { style = {} },
          ["@boolean.go"] = { style = {} },
          ["@operator.go"] = { style = {} },
          ["@punctuation.go"] = { style = {} },
          ["@constant.go"] = { style = {} },
          ["@lsp.type.variable.go"] = { fg = colors.text, style = {} },
          ["@lsp.type.parameter.go"] = { fg = colors.peach, style = {} },
          -- Disable italic for Go imports and packages
          ["@module.go"] = { style = {} },
          ["@module.builtin.go"] = { style = {} },
          ["@lsp.type.namespace.go"] = { style = {} },
          -- Thin transparent colorcolumn
          ColorColumn = { bg = colors.surface0 },
          -- Whitespace characters (tab, trailing spaces, etc.)
          SpecialKey = { fg = colors.surface2, style = {} },

          -- LSP Semantic Highlights
          ["@lsp.type.class"] = { fg = colors.yellow },
          ["@lsp.type.enum"] = { fg = colors.yellow },
          ["@lsp.type.interface"] = { fg = colors.yellow },
          ["@lsp.type.struct"] = { fg = colors.yellow },
          ["@lsp.type.variable"] = { fg = colors.text },
          ["@lsp.type.parameter"] = { fg = colors.peach },
          ["@lsp.type.function"] = { fg = colors.blue },

          -- Completion menu styling
          PmenuSel = { bg = colors.surface1, fg = colors.text, style = { "bold" } },
          Pmenu = { bg = colors.surface0, fg = colors.text },
          PmenuBorder = { fg = colors.surface2 },

          -- Inlay hints (function parameter hints, type hints, etc.)
          InlayHint = { fg = colors.surface2, style = { "italic" } },

          -- Diagnostic highlight groups
          DiagnosticError = { fg = colors.red },
          DiagnosticWarn = { fg = colors.yellow },
          DiagnosticInfo = { fg = colors.blue },
          DiagnosticHint = { fg = colors.green },
          DiagnosticVirtualTextError = { fg = colors.red, style = { "italic" } },
          DiagnosticVirtualTextWarn = { fg = colors.yellow, style = { "italic" } },
          DiagnosticVirtualTextInfo = { fg = colors.blue, style = { "italic" } },
          DiagnosticVirtualTextHint = { fg = colors.green, style = { "italic" } },
          DiagnosticUnderlineError = { sp = colors.red, style = { "underline" } },
          DiagnosticUnderlineWarn = { sp = colors.yellow, style = { "underline" } },

          -- Float window styling (hover, signature help, diagnostics)
          FloatBorder = { fg = colors.surface2, bg = colors.surface0 },
          FloatTitle = { fg = colors.blue, bg = colors.surface0, style = { "bold" } },
          NormalFloat = { bg = colors.surface0 },

          -- LSP signature help
          LspSignatureActiveParameter = { style = {} },

          -- Semantic Token Modifiers
          ["@lsp.mod.readonly"] = { style = { "italic" } },
          ["@lsp.mod.deprecated"] = { style = { "strikethrough" } },
          ["@lsp.mod.static"] = { fg = colors.mauve },

          -- Better Parentheses/Bracket Matching
          MatchParen = { fg = colors.pink, bg = colors.surface1, style = { "bold" } },

          -- Search Highlights
          Search = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
          IncSearch = { bg = colors.pink, fg = colors.base, style = { "bold" } },
          CurSearch = { bg = colors.pink, fg = colors.base, style = { "bold" } },

          -- Visual Selection
          Visual = { bg = colors.surface1, style = { "bold" } },
          VisualNOS = { bg = colors.surface1 },

          -- Better Cursorline
          CursorLine = { bg = colors.surface0 },
          CursorLineNr = { fg = colors.blue, bg = colors.surface0, style = { "bold" } },

          -- Code Lens
          LspCodeLens = { fg = colors.surface2, style = { "italic" } },
          LspCodeLensSign = { fg = colors.surface2 },
          LspCodeLensUnderline = { sp = colors.surface2, style = { "underline" } },

          -- Enhanced LSP References
          LspReferenceRead = { bg = colors.surface1 },
          LspReferenceText = { bg = colors.surface1 },
          LspReferenceWrite = { bg = colors.surface1 },

          -- Window Separators
          WinSeparator = { fg = colors.surface2 },
          VertSplit = { fg = colors.surface2 },

          -- Fold Styling
          Folded = { fg = colors.mauve, bg = colors.surface0, style = { "italic" } },
          FoldColumn = { fg = colors.surface2, bg = colors.surface0 },

          -- Diff Highlighting
          DiffAdd = { bg = colors.green, fg = colors.base },
          DiffDelete = { bg = colors.red, fg = colors.base },
          DiffChange = { bg = colors.yellow, fg = colors.base },
          DiffText = { bg = colors.blue, fg = colors.base, style = { "bold" } },

          -- Spell Check
          SpellBad = { sp = colors.red, style = { "undercurl" } },
          SpellCap = { sp = colors.yellow, style = { "undercurl" } },
          SpellLocal = { sp = colors.blue, style = { "undercurl" } },
          SpellRare = { sp = colors.mauve, style = { "undercurl" } },

          -- Command Mode/Message Area
          MsgArea = { fg = colors.text },
          MsgSeparator = { fg = colors.surface2, bg = colors.surface0 },

          -- Tab Styling
          TabLine = { bg = colors.surface0, fg = colors.surface2 },
          TabLineFill = { bg = colors.surface0 },
          TabLineSel = { bg = colors.surface1, fg = colors.text, style = { "bold" } },

          -- Markdown (Treesitter captures: markdown buffers and LSP hover/docs floats)
          ["@markup.heading.1.markdown"] = { fg = colors.red, style = { "bold" } },
          ["@markup.heading.2.markdown"] = { fg = colors.peach, style = { "bold" } },
          ["@markup.heading.3.markdown"] = { fg = colors.pink, style = { "bold" } },
          ["@markup.heading.4.markdown"] = { fg = colors.green, style = { "bold" } },
          ["@markup.heading.5.markdown"] = { fg = colors.teal, style = { "bold" } },
          ["@markup.heading.6.markdown"] = { fg = colors.mauve, style = { "bold" } },
          ["@markup.raw.block.markdown"] = { bg = colors.surface0, fg = colors.text },
          ["@markup.raw.markdown_inline"] = { bg = colors.surface0, fg = colors.pink },
          ["@markup.strong.markdown_inline"] = { fg = colors.mauve, style = { "bold" } },
          ["@markup.italic.markdown_inline"] = { fg = colors.teal, style = { "italic" } },
          ["@markup.link.markdown_inline"] = { fg = colors.sapphire, style = { "underline" } },
          ["@markup.link.label.markdown_inline"] = { fg = colors.teal },
        }
      end,
      -- auto_integrations (default) enables integrations for installed plugins;
      -- noice isn't auto-detected
      integrations = {
        noice = true,
      },
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("catppuccin-macchiato")
  end,
}
