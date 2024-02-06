return {
  'hrsh7th/nvim-cmp',
  version = false, -- last release is way too old
  event = 'VimEnter',
  dependencies = {
    'hrsh7th/cmp-cmdline',      -- command line
    'hrsh7th/cmp-buffer',       -- buffer completions
    'hrsh7th/cmp-nvim-lua',     -- nvim config completions
    'hrsh7th/cmp-nvim-lsp',     -- lsp completions
    'hrsh7th/cmp-path',         -- file path completions
    'saadparwaiz1/cmp_luasnip', -- snippets completions
    'onsails/lspkind-nvim',     -- vscode like icons
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    }
  },
  opts = function()
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

    local lspkind = require 'lspkind'
    local cmp = require('cmp')
    local luasnip = require 'luasnip'

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    require('luasnip.loaders.from_vscode').lazy_load();

    luasnip.add_snippets('typescript', {
      luasnip.snippet({ trig = 'async', dscr = 'Async arrow function' }, {
        luasnip.text_node('async ('),
        luasnip.insert_node(1),
        luasnip.text_node({ ') => {', '\t' }),
        luasnip.insert_node(2),
        luasnip.text_node({ '', '}' }),
      }),
      luasnip.snippet({ trig = 'const', name = 'some name', dscr = 'Const async arrow function' }, {
        luasnip.text_node('const '),
        luasnip.insert_node(1),
        luasnip.text_node(' = async ('),
        luasnip.insert_node(2),
        luasnip.text_node({ ') => {', '\t' }),
        luasnip.insert_node(3),
        luasnip.text_node({ '', '}' }),
      }),
      luasnip.snippet({ trig = '()', dscr = 'Arrow function' }, {
        luasnip.text_node('('),
        luasnip.insert_node(1),
        luasnip.text_node({ ') => {', '\t' }),
        luasnip.insert_node(2),
        luasnip.text_node({ '', '}' }),
      }),
      luasnip.snippet({ trig = 'it', dscr = 'Test case' }, {
        luasnip.text_node('it(\''),
        luasnip.insert_node(1),
        luasnip.text_node({ '\', () => {', '\t' }),
        luasnip.insert_node(2),
        luasnip.text_node({ '', '});' }),
      }),
      luasnip.snippet({ trig = 'it:async', dscr = 'Test case' }, {
        luasnip.text_node('it(\''),
        luasnip.insert_node(1),
        luasnip.text_node({ '\', async () => {', '\t' }),
        luasnip.insert_node(2),
        luasnip.text_node({ '', '});' }),
      }),
      luasnip.snippet({ trig = 'describe', dscr = 'Test suite' }, {
        luasnip.text_node('describe(\''),
        luasnip.insert_node(1),
        luasnip.text_node({ '\',' }),
        luasnip.insert_node(2),
        luasnip.text_node({ ');' }),
      }),
      luasnip.snippet({ trig = 'type', dscr = 'Type definition' }, {
        luasnip.text_node('type '),
        luasnip.insert_node(1),
        luasnip.text_node({ ' = {', '\t' }),
        luasnip.insert_node(2),
        luasnip.text_node({ '', '};' }),
      })
    });

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    });

    return {
      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.complete({ select = false }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = {
          i = function(fallback)
            if cmp.visible() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
        }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<S-CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end,
          s = function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end
        }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          'i',
          's',
        }),
      }),
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              nvim_lua = '[NVIM_LUA]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]
            return vim_item
          end,
        }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      experimental = {
        ghost_text = {
          hl_group = 'CmpGhostText',
        },
      },
    }
  end,
}
