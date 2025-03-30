return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config=function()
        require('kanagawa').setup({
            compile = true,             -- enable compiling the colorscheme
            -- transparent = true,         -- do not set background color
            overrides=function(colors)
                return {
                    ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
                    ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
                    ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
                    ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
                    ["@markup.list.markdown"] = { link = "Function" }, -- + list
                    ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
                    ["@markup.list.checked.markdown"] = {link = "WarningMsg" } -- -[x] check list
                }
            end,
        });
        vim.cmd("colorscheme kanagawa-wave")
        -- vim.cmd("colorscheme kanagawa-dragon")
        -- vim.cmd("colorscheme kanagawa-lotus")
    end,
    build = function()
        vim.cmd("KanagawaCompile");
    end,
}

