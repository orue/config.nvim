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
      },

      appearance = {
        use_nvim_cmp_as_default = true,
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

      signature = { enabled = true }
    },
  },
}
