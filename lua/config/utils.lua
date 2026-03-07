-- Utility functions for Neovim configuration
local M = {}

-- Common venv directory names
local venv_dirs = { '.venv', 'venv', 'env' }

--- Find a virtual environment by walking up from dir
--- @param start_dir string Starting directory
--- @return string|nil venv_path Absolute path to venv directory, or nil
local function find_venv(start_dir)
  local dir = start_dir
  while dir and dir ~= '/' do
    for _, name in ipairs(venv_dirs) do
      local candidate = dir .. '/' .. name
      if vim.fn.isdirectory(candidate) == 1 and vim.fn.executable(candidate .. '/bin/python') == 1 then
        return candidate
      end
    end
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return nil
end

--- Get virtual environment info for Pyright settings
--- @return { venv_path: string, venv_name: string }|nil
function M.get_venv_info()
  -- 1. Check VIRTUAL_ENV env var
  local env_venv = vim.env.VIRTUAL_ENV
  if env_venv and vim.fn.isdirectory(env_venv) == 1 then
    return {
      venv_path = vim.fn.fnamemodify(env_venv, ':h'),
      venv_name = vim.fn.fnamemodify(env_venv, ':t'),
    }
  end

  -- 2. Walk up from cwd looking for venv dirs
  local venv = find_venv(vim.fn.getcwd())
  if venv then
    return {
      venv_path = vim.fn.fnamemodify(venv, ':h'),
      venv_name = vim.fn.fnamemodify(venv, ':t'),
    }
  end

  return nil
end

--- Get the Python executable path
--- Checks: VIRTUAL_ENV → .venv/venv/env in cwd+parents → system python
--- @return string Python executable path
function M.get_python_path()
  -- 1. Check VIRTUAL_ENV env var
  local env_venv = vim.env.VIRTUAL_ENV
  if env_venv then
    local py = env_venv .. '/bin/python'
    if vim.fn.executable(py) == 1 then
      return py
    end
  end

  -- 2. Walk up from cwd looking for venv dirs
  local venv = find_venv(vim.fn.getcwd())
  if venv then
    return venv .. '/bin/python'
  end

  -- 3. Fallback to system python
  if vim.fn.executable('python3') == 1 then
    return vim.fn.exepath('python3')
  elseif vim.fn.executable('python') == 1 then
    return vim.fn.exepath('python')
  end

  vim.notify("Python executable not found, using 'python3'", vim.log.levels.WARN)
  return 'python3'
end

--- Check if a virtual environment exists (cwd or parents)
--- @return boolean
function M.has_venv()
  return find_venv(vim.fn.getcwd()) ~= nil or vim.env.VIRTUAL_ENV ~= nil
end

return M
