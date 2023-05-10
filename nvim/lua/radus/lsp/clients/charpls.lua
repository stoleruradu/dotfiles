local nvim_lsp = require 'lspconfig'

vim.env.DOTNET_ROOT = '/usr/local/share/dotnet'

local M = {}

M.setup = function(on_attach)
  nvim_lsp.csharp_ls.setup {
    cmd = { '/Users/radustoleru/.dotnet/tools/csharp-ls' },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
  }
end

return M
