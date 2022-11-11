require('radus.plugins.packer')

require('radus.plugins.configs.compe')
require('radus.plugins.configs.lualine')
require('radus.plugins.configs.nvimtree')
require('radus.plugins.configs.treesitter')
require('radus.plugins.configs.telescope')
require('radus.plugins.configs.gitsigns')
require('radus.plugins.configs.lspsaga')

require('neoscroll').setup()
require('neogit').setup({
    kind = 'split'
})
