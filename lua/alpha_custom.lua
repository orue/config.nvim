local M = {}

function M.create_new_project()
  vim.ui.input({ prompt = "Project name: " }, function(project_name)
    if not project_name or project_name == "" then
      return
    end

    vim.ui.input({
      prompt = "Location (default ~/dev): ",
      default = vim.fn.expand("~/dev"),
      completion = "dir"
    }, function(location)
      if not location or location == "" then
        location = vim.fn.expand("~/dev")
      end

      -- Expand home directory
      location = vim.fn.expand(location)

      -- Create full path
      local project_path = location .. "/" .. project_name

      -- Create the directory
      vim.fn.mkdir(project_path, "p")

      -- Change to the new directory and open Oil
      vim.cmd("cd " .. project_path)
      vim.cmd("Oil")
    end)
  end)
end

return M
