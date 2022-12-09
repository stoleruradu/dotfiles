local nvim_lsp = require 'lspconfig'

nvim_lsp.eslint.setup({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    -- vim.api.nvim_command [[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]
  end,
})

