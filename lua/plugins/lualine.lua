return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
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
                        "filetype",
                        icon_only = false,   -- Show both icon and filetype name
                        colored = true,        -- Color the icon based on filetype
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
