return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    version = '1.*',

    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-Space>'] = { 'show', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'mono',

        kind_icons = {
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',
          Field = '󰆨',
          Variable = '󰀫',
          Class = '󰠱',
          Interface = '󰕘',
          Struct = '󰌗',
          Module = '󰅩',
          Property = '󰖷',
          Enum = '󰕘',
          Operator = '󰆕',
          Keyword = '󰌋',
          Snippet = '󰍌',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰈇',
          Folder = '󰉋',
          EnumMember = '󰜢',
          Constant = '󰏿',
          Event = '󰉁',
          Namespace = '󰅩',
          Package = '󰆦',
          String = '󰀬',
          Number = '󰎠',
          Boolean = '󰨙',
          Array = '󰅪',
          Object = '󰅩',
          Key = '󰌋',
          Null = '󰟢',
          TypeParameter = '󰆩',
        },
      },

      completion = {
        menu = {
          border = 'rounded',
          max_height = 15,
          scrollbar = true,
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = 'rounded',
            max_width = 60,
            max_height = 20,
          },
        },
        ghost_text = {
          enabled = true,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      signature = { enabled = true },
    },
  },
}
