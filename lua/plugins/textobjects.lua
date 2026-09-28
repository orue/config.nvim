-- Code-aware text objects: select or jump by function, class and argument
-- (vaf selects a function, cif rewrites its body, ]f jumps to the next function)
local function select(capture)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
  end
end

local function move(fn, capture)
  return function()
    require("nvim-treesitter-textobjects.move")[fn](capture, "textobjects")
  end
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main", -- matches nvim-treesitter's main branch
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    select = {
      lookahead = true, -- jump forward to the next match when the cursor isn't inside one
      -- whole functions/classes select full lines, so daf leaves no empty line behind
      selection_modes = { ["@function.outer"] = "V", ["@class.outer"] = "V" },
    },
    move = { set_jumps = true },   -- ]f / [f are added to the jumplist (Ctrl+o returns)
  },
  keys = {
    { "af", select("@function.outer"), mode = { "x", "o" }, desc = "a function" },
    { "if", select("@function.inner"), mode = { "x", "o" }, desc = "inner function" },
    { "ac", select("@class.outer"), mode = { "x", "o" }, desc = "a class" },
    { "ic", select("@class.inner"), mode = { "x", "o" }, desc = "inner class" },
    { "aa", select("@parameter.outer"), mode = { "x", "o" }, desc = "an argument" },
    { "ia", select("@parameter.inner"), mode = { "x", "o" }, desc = "inner argument" },
    { "]f", move("goto_next_start", "@function.outer"), mode = { "n", "x", "o" }, desc = "Next function" },
    { "[f", move("goto_previous_start", "@function.outer"), mode = { "n", "x", "o" }, desc = "Previous function" },
  },
}
