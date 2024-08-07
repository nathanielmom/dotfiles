return {
 'hrsh7th/nvim-cmp',
 event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',         -- Ensure LuaSnip is installed by Packer
    'saadparwaiz1/cmp_luasnip', -- Plugin to make LuaSnip work with cmp
    'onsails/lspkind-nvim',     -- Glyph icons in the suggestion menu
  },
  config = function()

    -- nvim-cmp setup
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    require('luasnip/loaders/from_snipmate').lazy_load()

    -- stop cmp and luasnip from making the curson jump around
    luasnip.config.set_config({
      region_check_events = 'InsertEnter',
      delete_check_events = 'InsertLeave'
    })

    require('luasnip/loaders/from_snipmate').lazy_load()

    -- Determine how cmp should behave it there is a character ahead of the cursor.
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        format = require('lspkind').cmp_format(),
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        -- { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      },
    }
  end
}
