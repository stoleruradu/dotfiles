local nvim_lsp = require 'lspconfig'
local runtime_path = vim.split(package.path, ';')

local M = {}

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

M.init = function(on_attach)
  nvim_lsp.lua_ls.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      client.server_capabilities.documentRangeFormattingProvider = true

      on_attach(client, bufnr, true)
    end,
    settings = {
      Lua = {
        format = {
          enable = true,
        },
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          -- For some reason havin setting this line below as the docs suggest
          -- open a quick-fix window every time you jump to a reference
          -- library = vim.api.nvim_get_runtime_file("", true),
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M
