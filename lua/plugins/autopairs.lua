return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,  -- Enable treesitter integration
    ts_config = {
      lua = { "string" },  -- Don't add pairs in lua string nodes
      javascript = { "template_string" },
    },
    -- fast_wrap uses defaults, disable_filetype uses defaults
  },
}
