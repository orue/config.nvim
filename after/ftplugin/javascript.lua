-- JavaScript: 2-space indent, 100-char ruler
local lang = require("config.lang")
lang.setup_buffer({ indent = 2, width = 100 })
lang.map_organize_imports()

-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)
