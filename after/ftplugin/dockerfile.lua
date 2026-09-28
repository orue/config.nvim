-- Dockerfile: 4-space indent, 120-char ruler (long RUN commands)
require("config.lang").setup_buffer({ indent = 4, width = 120 })

-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)
