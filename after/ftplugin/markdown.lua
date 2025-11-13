-- Markdown-specific configuration

-- Enhance markdown colors for Catppuccin Mocha
local colors = require("catppuccin.palettes").get_palette("mocha")

-- Headings with distinct colors
vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = colors.red, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = colors.peach, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = colors.pink, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = colors.green, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = colors.teal, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = colors.mauve, bold = true })

-- Make code blocks stand out
vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { bg = colors.surface0, fg = colors.text })
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = colors.surface0, fg = colors.pink })

-- Emphasize bold/italic
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = colors.mauve, bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = colors.teal, italic = true })

-- Links
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { fg = colors.sapphire, underline = true })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = colors.teal })

-- Better line breaking for markdown
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2  -- Hide markup for cleaner view
vim.opt_local.spell = true       -- Enable spell check
vim.opt_local.textwidth = 80     -- Wrap at 80 characters

-- Markdown-specific keybindings
local map = vim.keymap.set
map("n", "<leader>mt", "i- [ ] ", { buffer = true, desc = "Insert TODO checkbox" })
map("n", "<leader>mc", "<cmd>s/- \\[ \\]/- [x]/<cr>", { buffer = true, desc = "Check TODO" })
map("n", "<leader>mu", "<cmd>s/- \\[x\\]/- [ ]/<cr>", { buffer = true, desc = "Uncheck TODO" })
