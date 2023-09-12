local lspconfig = require('lspconfig')
local util = require 'lspconfig/util'

local M = {};

M.init = function(on_attach)
  lspconfig.gopls.setup {
    on_attach = on_attach,
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
end

return M;
