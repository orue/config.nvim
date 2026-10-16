-- Rust: 4-space indent, 100-char ruler (rustfmt's max_width)
local lang = require("config.lang")
lang.setup_buffer({ indent = 4, width = 100 })

-- Note: <leader>rf formatting is handled by conform.nvim (see lua/plugins/formatter.lua);
-- rustfmt also sorts `use` statements, so there is no organize-imports key

-- Run `cargo <args>` from the current file's directory (cargo picks the enclosing package)
local function cargo(args)
  local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))
  vim.cmd("!cd " .. dir .. " && cargo " .. args)
end

local function rust_analyzer()
  local client = vim.lsp.get_clients({ bufnr = 0, name = "rust_analyzer" })[1]
  if not client then
    vim.notify("rust-analyzer is not attached", vim.log.levels.WARN)
  end
  return client
end

-- Run the test (or test module) under the cursor, using rust-analyzer's runnables
vim.keymap.set("n", "<leader>ru", function()
  local client = rust_analyzer()
  if not client then return end
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request("experimental/runnables", params, function(err, runnables)
    if err or not runnables then return end
    -- Innermost test runnable around the cursor (a test fn beats its `mod tests`)
    local best, best_lines
    for _, r in ipairs(runnables) do
      local range = r.location and r.location.targetRange
      if range and r.kind == "cargo" and vim.tbl_contains(r.args.cargoArgs, "test") then
        local lines = range["end"].line - range.start.line
        if not best or lines < best_lines then
          best, best_lines = r, lines
        end
      end
    end
    if not best then
      vim.notify("No test under the cursor", vim.log.levels.WARN)
      return
    end
    local cmd = vim.list_extend({ "cargo" }, best.args.cargoArgs)
    if #best.args.executableArgs > 0 then
      vim.list_extend(cmd, { "--" })
      vim.list_extend(cmd, best.args.executableArgs)
    end
    local cwd = best.args.cwd or best.args.workspaceRoot
    local shell_cmd = table.concat(vim.tbl_map(vim.fn.shellescape, cmd), " ")
    vim.cmd("!cd " .. vim.fn.shellescape(cwd) .. " && " .. shell_cmd)
  end, 0)
end, { buffer = true, desc = "Run test under cursor" })

vim.keymap.set("n", "<leader>rt", function()
  cargo("test")
end, { buffer = true, desc = "Run tests (current package)" })

vim.keymap.set("n", "<leader>re", function()
  cargo("test --workspace")
end, { buffer = true, desc = "Run all tests (workspace)" })

vim.keymap.set("n", "<leader>rr", function()
  cargo("run")
end, { buffer = true, desc = "Cargo run" })

vim.keymap.set("n", "<leader>rab", function()
  cargo("bench")
end, { buffer = true, desc = "Run benchmarks" })

-- Show the macro under the cursor fully expanded, in a float
vim.keymap.set("n", "<leader>rx", function()
  local client = rust_analyzer()
  if not client then return end
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request("rust-analyzer/expandMacro", params, function(err, result)
    if err or not result then
      vim.notify("No macro under the cursor", vim.log.levels.WARN)
      return
    end
    vim.lsp.util.open_floating_preview(vim.split(result.expansion, "\n"), "rust", {
      border = "rounded",
      title = result.name .. "!",
      title_pos = "center",
    })
  end, 0)
end, { buffer = true, desc = "Expand macro" })

-- Jump to the Cargo.toml of the package this file belongs to
vim.keymap.set("n", "<leader>ro", function()
  local client = rust_analyzer()
  if not client then return end
  local params = { textDocument = vim.lsp.util.make_text_document_params(0) }
  client:request("experimental/openCargoToml", params, function(err, location)
    if err or not location then return end
    vim.lsp.util.show_document(location, client.offset_encoding, { focus = true })
  end, 0)
end, { buffer = true, desc = "Open Cargo.toml" })
