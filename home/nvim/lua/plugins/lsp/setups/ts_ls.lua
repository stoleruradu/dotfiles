local util = require 'lspconfig.util';
local buf_map = vim.api.nvim_buf_set_keymap;

return {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    vim.api.nvim_create_user_command('LspOrganize', function()
      local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ''
      }
      vim.lsp.buf.execute_command(params)
    end, {})

    buf_map(bufnr, 'n', '<leader>fo', ':LspOrganize<cr>', { silent = true })
  end,
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript' },
  root_dir = util.root_pattern('tsconfig.json', '.git')
}
