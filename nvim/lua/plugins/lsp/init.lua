local config = vim.fn.stdpath('config');
local servers_path = config .. '/lua/plugins/lsp/servers';


-- TODO: move this to utils
local ls = function(path)
  local handle = vim.loop.fs_scandir(path)
  local files = {};

  while handle do
    local name, type = vim.loop.fs_scandir_next(handle)

    if not name then
      break
    end

    local fname = path .. '/' .. name;

    table.insert(files, {
      fname = fname,
      name = name,
      type = type,
    })
  end

  return files;
end

local servers = ls(servers_path);
local ensure_installed = {};

for _, file in ipairs(servers) do
  if file.name:sub(-4) == '.lua' then
    table.insert(ensure_installed, file.name:sub(1, -5));
  end
end


local setup_apearence = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = false,
      severity_sort = true,
    }
  )

  local signs = { Error = '', Warn = '', Hint = '', Info = '' }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

local setup_commands = function()
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
end

local setup_keymaps = function(buffer)
  vim.keymap.set('n', '<leader>fp', ':Format<cr>', { buffer = buffer, silent = true }) -- format pretty
  vim.keymap.set('n', 'gd', ':LspDef<cr>', { buffer = buffer, silent = true })
  vim.keymap.set('n', 'gR', ':Lspsaga rename<cr>', { buffer = buffer, silent = true })
  vim.keymap.set('n', 'gr', ':Lspsaga finder<cr>', { buffer = buffer, silent = true })
  vim.keymap.set('n', 'gy', ':LspTypeDef<cr>', { buffer = buffer, silent = true })
  vim.keymap.set('n', 'K', ':Lspsaga hover_doc<cr>', { buffer = buffer, silent = true })

  vim.keymap.set('n', '[e', function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)

  vim.keymap.set('n', ']e', function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  vim.keymap.set('n', 'ga', ':Lspsaga code_action<cr>', { buffer = buffer, silent = true })
  vim.keymap.set('n', '<Leader><space>', ':Lspsaga show_line_diagnostics<cr>',
    { buffer = buffer, silent = true })
  vim.keymap.set('i', '<C-x><C-x>', '<cmd> LspSignatureHelp<cr>', { buffer = buffer, silent = true })
end

local setup_formating = function(buffer, client)
  if client.server_capabilities.documentFormattingProvider then
    return;
  end

  local group = vim.api.nvim_create_augroup('Format' .. tostring(buffer), {})

  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = group,
    buffer = buffer,
    callback = function()
      vim.lsp.buf.format()
    end,
  })

  vim.api.nvim_create_autocmd('BufDelete', {
    buffer = buffer,
    callback = function(opt)
      pcall(vim.api.nvim_del_augroup_by_id, opt.buf)
    end,
  })
end

return {
  { dir = '/Users/radustoleru/Projects/stoleruradu/nodejstools.nvim', opts = {} },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local nvim_lsp = require 'lspconfig'

      setup_apearence();
      setup_commands();

      for _, server in ipairs(ensure_installed) do
        local import = 'plugins.lsp.servers' .. '.' .. server;
        local ok, opts = pcall(require, import)

        if ok and nvim_lsp[server] and nvim_lsp[server].setup then
          local setup_defaults = opts.on_attach or function() end;

          opts.on_attach = function(client, buffer)
            setup_defaults(client, buffer);
            setup_keymaps(buffer);
            setup_formating(buffer, client);
          end

          nvim_lsp[server].setup(opts);
        end
      end
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
      ensure_installed = ensure_installed
    },
    dependencies = { 'williamboman/mason.nvim' }
  },

}
