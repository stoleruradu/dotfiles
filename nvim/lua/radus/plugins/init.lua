require('radus.plugins.packer')
require('neoscroll').setup()
require('neogit').setup({
  kind = 'split'
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'sumneko_lua', 'tsserver', 'eslint', 'jsonls' }
})
