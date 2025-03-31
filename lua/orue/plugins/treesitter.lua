return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        { "windwp/nvim-ts-autotag", commit = "e239a560f338be31337e7abc3ee42515daf23f5e" },
        { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects
        {
            "nvim-treesitter/nvim-treesitter-context",       -- Show code context
            opts = { enable = true, mode = "topline", line_numbers = true }
        }
    },
    config = function () 
        local configs = require("nvim-treesitter.configs")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"markdown"},
            callback = function(ev)
                -- treesitter-context is buggy with Markdown files
                require("treesitter-context").disable()
            end
        })


        configs.setup({
            -- enable syntax highlighting
            highlight = { 
                enable = true,
                disable = { "csv" }
            },

            -- enable indentation
            indent = { enable = true },

            -- ensure these language parsers are installed
            ensure_installed = {
                "lua",
                "python",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "javascript",
                "typescript",
                "vue",
                "astro",
                "svelte",
                "tsx",
                "c",
                "cpp",
                "sql",
                "regex",
                "terraform",
                "dockerfile",
                "prisma",
                "markdown",
                "markdown_inline",
                "vimdoc",
                "json",
                "gitignore",
                "git_config",
                "graphql",
                "yaml",
                "toml",
                "xml",
                "make",
                "cmake",
                "comment",
                "bash",
                "html",
                "css",
            },


            auto_install = true,
            sync_install = false,
            textobjects = {select = {enable = true, lookahead = true}},
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>",
                    node_incremental = "<Enter>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {select = {enable = true, lookahead = true}}
        })
        require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		})
    end
}

