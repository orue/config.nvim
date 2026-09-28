-- Python: 4-space indent, 120-char ruler
local lang = require("config.lang")
lang.setup_buffer({ indent = 4, width = 120 })
lang.map_organize_imports()

-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua)
