local set = vim.opt_local

-- Dockerfile formatting settings
-- Dockerfiles typically use 4 spaces or tabs for indentation
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4

-- Useful for long RUN commands
set.textwidth = 120
set.colorcolumn = "120"
