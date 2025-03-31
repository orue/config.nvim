return 
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "meuter/lualine-so-fancy.nvim",
        },
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                -- component_separators = { left = "│", right = "│" },
                -- section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                globalstatus = true,
                refresh = {
                    statusline = 100,
                },
                disabled_filetypes = {
                    statusline = {
                        "alpha",
                        "checkhealth",
                        "dashboard",
                        "snacks_dashboard",
                        "fzf",
                        "lazy",
                        "mason",
                        "TelescopePrompt",
                    },
                },
            },
            sections = {
                lualine_a = {
                    { "fancy_mode", width = 1 }
                },
                lualine_b = {
                    { "fancy_branch" },
                    { "fancy_diff" },
                },
                lualine_c = {
                    { "fancy_cwd", substitute_home = true }
                },
                lualine_x = {
                    { "fancy_macro" },
                    { "fancy_diagnostics" },
                    { "fancy_searchcount" },
                    { "fancy_location" },
                },
                lualine_y = {
                    { "fancy_filetype", ts_icon = "" }
                },
                lualine_z = {
                    { "fancy_lsp_servers" }
                },
            },
        },
    }
