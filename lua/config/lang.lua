-- Helpers shared by after/ftplugin/*.lua
local M = {}

--- Buffer-local indentation and ruler for a code filetype
--- @param opts { indent: integer, tabs?: boolean, width?: integer }
function M.setup_buffer(opts)
  local o = vim.opt_local
  o.expandtab = not opts.tabs
  o.tabstop = opts.indent
  o.shiftwidth = opts.indent
  o.softtabstop = opts.indent
  if opts.width then
    o.textwidth = opts.width
    o.colorcolumn = tostring(opts.width)
  end
  -- textwidth wraps comments only, never code
  o.formatoptions:remove("t")
end

--- Map a key to apply the LSP code action of the given kind (e.g. "source.organizeImports")
--- @param lhs string
--- @param kind string
--- @param desc string
function M.map_code_action(lhs, kind, desc)
  vim.keymap.set("n", lhs, function()
    vim.lsp.buf.code_action({ context = { only = { kind }, diagnostics = {} }, apply = true })
  end, { buffer = true, desc = desc })
end

--- <leader>ri: organize imports through the LSP
function M.map_organize_imports()
  M.map_code_action("<leader>ri", "source.organizeImports", "Organize imports")
end

return M
