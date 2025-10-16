return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "tokyonight-storm",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = { statusline = {}, winbar = {} },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
            symbols = { modified = " ●", readonly = " ", unnamed = " [No Name]" },
          }
        },
        lualine_x = {
          {
            function()
              if vim.bo.filetype == "python" then
                local venv_path = vim.fn.getcwd() .. "/.venv"
                if vim.fn.isdirectory(venv_path) == 1 then
                  return "(.venv)"
                end
              end
              return ""
            end,
            color = { fg = "#7aa2f7" }
          },
          {
            "filetype",
            icon_only = false, -- Show both icon and filetype name
            colored = true,    -- Color the icon based on filetype
            icon = { align = "left" }
          },
          "encoding",
          "fileformat"
        },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
