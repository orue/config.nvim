-- Utility functions for Neovim configuration
local M = {}

--- Get the Python executable path
--- Checks for .venv in current directory, then falls back to system Python
--- @return string Python executable path
function M.get_python_path()
  local cwd = vim.fn.getcwd()

  -- Check for .venv first
  local venv_path = cwd .. '/.venv/bin/python'
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end

  -- Fallback to system python3, then python
  if vim.fn.executable('python3') == 1 then
    return vim.fn.exepath('python3')
  elseif vim.fn.executable('python') == 1 then
    return vim.fn.exepath('python')
  end

  -- Last resort fallback
  return 'python3'
end

--- Check if a virtual environment exists in the current directory
--- @return boolean True if .venv directory exists
function M.has_venv()
  local venv_path = vim.fn.getcwd() .. "/.venv"
  return vim.fn.isdirectory(venv_path) == 1
end

return M
