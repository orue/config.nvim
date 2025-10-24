return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                                                        ",
      "                                                                                        ",
      "      ███████╗██████╗ ██╗████████╗ ██████╗ ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
      "      ██╔════╝██╔══██╗██║╚══██╔══╝██╔═══██╗██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║",
      "      █████╗  ██║  ██║██║   ██║   ██║   ██║██████╔╝    ██╔██╗ ██║██║   ██║██║██╔████╔██║",
      "      ██╔══╝  ██║  ██║██║   ██║   ██║   ██║██╔══██╗    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "      ███████╗██████╔╝██║   ██║   ╚██████╔╝██║  ██║    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "      ╚══════╝╚═════╝ ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "                                                                                        ",
      "                                                                                        ",
    }

    -- Cache for recent projects (memoization)
    local recent_projects_cache = nil
    local cache_timestamp = 0
    local cache_ttl = 300  -- 5 minutes in seconds

    -- Function to get recent directories with caching
    local function get_recent_projects()
      local current_time = os.time()

      -- Return cached result if still valid
      if recent_projects_cache and (current_time - cache_timestamp) < cache_ttl then
        return recent_projects_cache
      end

      -- Recalculate projects
      local oldfiles = vim.v.oldfiles or {}
      local seen_dirs = {}
      local projects = {}
      local home = vim.fn.expand("~")

      for _, file in ipairs(oldfiles) do
        if #projects >= 5 then break end

        -- Get directory from file
        local dir = vim.fn.fnamemodify(file, ":h")

        -- Skip if we've seen this directory or if it doesn't exist
        if not seen_dirs[dir] and vim.fn.isdirectory(dir) == 1 then
          seen_dirs[dir] = true

          -- Get the project name (last directory in path)
          local project_name = vim.fn.fnamemodify(dir, ":t")

          -- Shorten the path for display
          local display_path = dir:gsub(vim.pesc(home), "~")
          if #display_path > 50 then
            display_path = "..." .. display_path:sub(-47)
          end

          table.insert(projects, {
            name = project_name,
            path = dir,
            display = display_path,
          })
        end
      end

      -- Update cache
      recent_projects_cache = projects
      cache_timestamp = current_time

      return projects
    end

    -- Create recent projects section
    local function create_recent_projects_section()
      local projects = get_recent_projects()
      local section = {
        type = "group",
        val = {},
        opts = { hl = "AlphaRecent" },
      }

      if #projects > 0 then
        -- Header for recent projects
        table.insert(section.val, {
          type = "text",
          val = "  Recent Projects",
          opts = { hl = "AlphaShortcut", position = "center" },
        })
        table.insert(section.val, { type = "padding", val = 1 })

        -- Add each project
        for i, project in ipairs(projects) do
          local button = dashboard.button(
            tostring(i),
            "  " .. project.name .. " → " .. project.display,
            ":cd " .. project.path .. " | Oil <CR>"
          )
          button.opts.width = 80
          button.opts.cursor = 5
          table.insert(section.val, button)
        end
      end

      return section
    end

    -- Set menu with wider layout
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file                     ", ":ene <BAR> startinsert <CR>"),
      dashboard.button("n", "  New project                  ", ":lua require('alpha_custom').create_new_project()<CR>"),
      dashboard.button("f", "  Find file                    ", ":Telescope find_files <CR>"),
      dashboard.button("r", "  Recent files                 ", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "  Find text                    ", ":Telescope live_grep <CR>"),
      dashboard.button("b", "  Browse files                 ", ":Oil <CR>"),
      dashboard.button("c", "  Configuration                ", ":e ~/.config/nvim/init.lua <CR>"),
      dashboard.button("q", "  Quit                         ", ":qa<CR>"),
    }

    -- Make buttons wider
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.width = 80
      button.opts.cursor = 5
    end

    -- Set footer
    local function footer()
      local datetime = os.date("  %Y-%m-%d   %H:%M:%S")
      local version = vim.version()
      local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
      local total_plugins = #vim.tbl_keys(require("lazy").plugins())
      return datetime .. "          " .. nvim_version_info .. "          ⚡ " .. total_plugins .. " plugins"
    end

    dashboard.section.footer.val = footer()

    -- Styling
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"

    -- Create recent projects section
    local recent_projects = create_recent_projects_section()

    -- Layout
    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      {
        type = "text",
        val = "  Quick Actions",
        opts = { hl = "AlphaShortcut", position = "center" },
      },
      { type = "padding", val = 1 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      recent_projects,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    -- Disable folding on alpha buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })

    -- Send config to alpha
    alpha.setup(dashboard.config)

    -- Auto open alpha when last buffer is closed
    vim.api.nvim_create_autocmd("User", {
      pattern = "BDeletePost*",
      callback = function(event)
        local fallback_name = vim.api.nvim_buf_get_name(event.buf)
        local fallback_ft = vim.bo[event.buf].filetype
        local fallback_on_empty = fallback_name == "" and fallback_ft == ""

        if fallback_on_empty then
          vim.cmd("Alpha")
        end
      end,
    })
  end,
}
