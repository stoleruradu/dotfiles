require('radus.plugins.packer')
require('neoscroll').setup()
require('neogit').setup({
  kind = 'split'
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'eslint', 'jsonls', 'omnisharp', 'lua_ls' }
})
