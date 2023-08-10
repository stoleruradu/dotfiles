return {
  { dir = '/Users/radustoleru/Projects/stoleruradu/nodejstools.nvim', opts = {} },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local protocol = require 'vim.lsp.protocol'

      local on_attach = function(client, bufnr, auto_format)
        local buf_map = vim.api.nvim_buf_set_keymap

        vim.api.nvim_create_user_command('Format', function()
          vim.lsp.buf.format({ async = true })
        end, {})

        vim.api.nvim_create_user_command('LspDefinition', function()
          vim.lsp.buf.definition()
        end, {})

        vim.api.nvim_create_user_command('LspCodeAction', function()
          vim.lsp.buf.code_action()
        end, {})

        vim.api.nvim_create_user_command('LspHover', function()
          vim.lsp.buf.hover()
        end, {})

        vim.api.nvim_create_user_command('LspRename', function()
          vim.lsp.buf.rename()
        end, {})

        vim.api.nvim_create_user_command('LspRefs', function()
          vim.api.nvim_command('Telescope lsp_references')
        end, {})

        vim.api.nvim_create_user_command('LspTypeDef', function()
          vim.lsp.buf.type_definition()
        end, {})

        vim.api.nvim_create_user_command('LspImplementation', function()
          vim.lsp.buf.implementation()
        end, {})

        vim.api.nvim_create_user_command('LspDiagPrev', function()
          vim.lsp.diagnostic.goto_prev()
        end, {})

        vim.api.nvim_create_user_command('LspDiagNext', function()
          vim.lsp.diagnostic.goto_next()
        end, {})

        vim.api.nvim_create_user_command('LspDiagLine', function()
          vim.diagnostic.open_float()
        end, {})

        vim.api.nvim_create_user_command('LspSignatureHelp', function()
          vim.lsp.buf.signature_help()
        end, {})

        buf_map(bufnr, 'n', '<leader>fp', ':Format<cr>', { silent = true }) -- format pretty
        buf_map(bufnr, 'n', 'gd', ':LspDef<cr>', { silent = true })
        buf_map(bufnr, 'n', 'gR', ':Lspsaga rename<cr>', { silent = true })
        buf_map(bufnr, 'n', 'gr', ':Lspsaga finder<cr>', { silent = true })
        buf_map(bufnr, 'n', 'gy', ':LspTypeDef<cr>', { silent = true })
        buf_map(bufnr, 'n', 'K', ':Lspsaga hover_doc<cr>', { silent = true })
        buf_map(bufnr, 'n', '[a', ':LspDiagPrev<cr>', { silent = true })
        buf_map(bufnr, 'n', ']a', ':LspDiagNext<cr>', { silent = true })
        buf_map(bufnr, 'n', 'ga', ':Lspsaga code_action<cr>', { silent = true })
        buf_map(bufnr, 'n', '<Leader><space>', ':Lspsaga show_line_diagnostics<cr>', { silent = true })
        buf_map(bufnr, 'i', '<C-x><C-x>', '<cmd> LspSignatureHelp<cr>', { silent = true })

        if client.server_capabilities.documentFormattingProvider and auto_format then
          local group = vim.api.nvim_create_augroup('Format' .. tostring(bufnr), {})

          vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })

          vim.api.nvim_create_autocmd('BufDelete', {
            buffer = bufnr,
            callback = function(opt)
              pcall(vim.api.nvim_del_augroup_by_id, opt.buf)
              -- if buf_auid[opt.buf] then
              --   rawset(buf_auid, opt.buf, nil)
              -- end
            end,
          })
        end

        protocol.CompletionItemKind = {
          '', -- Text
          '', -- Method
          '', -- Function
          '', -- Constructor
          '', -- Field
          '', -- Variable
          '', -- Class
          'ﰮ', -- Interface
          '', -- Module
          '', -- Property
          '', -- Unit
          '', -- Value
          '', -- Enum
          '', -- Keyword
          '﬌', -- Snippet
          '', -- Color
          '', -- File
          '', -- Reference
          '', -- Folder
          '', -- EnumMember
          '', -- Constant
          '', -- Struct
          '', -- Event
          'ﬦ', -- Operator
          '', -- TypeParameter
        }
      end

      -- icon
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = false,
          severity_sort = true,
          --virtual_text = {
          --  spacing = 4,
          --  prefix = '»'
          --}
        }
      )

      --   added = " ",
      -- modified = " ",
      -- removed = " ",
      --  saga.init_lsp_saga {
      -- error_sign = '', -- 
      --  let g:airline_left_sep = '▶'
      --  \ 'separator': { 'left': '', 'right': '' },
      --  prefix = '●', -- Could be '■', '▎', 'x'
      local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end


      require('plugins.lsp.servers.lua_ls').init(on_attach);
      require('plugins.lsp.servers.ts_ls').init(on_attach);
      require('plugins.lsp.servers.eslint_ls')
      require('plugins.lsp.servers.json_ls')
      require('plugins.lsp.servers.charp_ls').init(on_attach)
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = { 'tsserver', 'eslint', 'omnisharp', 'jsonls', 'lua_ls' }
    },
    dependencies = { 'williamboman/mason.nvim' }
  },

}
