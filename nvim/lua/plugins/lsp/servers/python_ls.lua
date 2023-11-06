local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities();

local M = {};

M.init = function(on_attach)
  lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M;
