return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local utils = require('config.utils')
    local colors = require("catppuccin.palettes").get_palette("macchiato")

    require("lualine").setup {
      options = {
        theme = "catppuccin",
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
              local reg = vim.fn.reg_recording()
              if reg ~= "" then
                return "recording @" .. reg
              end
              return ""
            end,
            color = { fg = colors.red },
          },
          {
            function()
              if vim.bo.filetype == "markdown" then
                local wc = vim.fn.wordcount()
                return wc.words .. " words"
              end
              return ""
            end,
            color = { fg = colors.lavender },
          },
          {
            function()
              if vim.bo.filetype == "python" and utils.has_venv() then
                return "(.venv)"
              end
              return ""
            end,
            color = { fg = colors.teal }
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "" end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return " " .. table.concat(names, ", ")
            end,
            color = { fg = colors.subtext0 },
          },
          {
            "filetype",
            icon_only = false,
            colored = true,
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
