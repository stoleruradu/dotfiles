require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    'tsx',
    'json',
    'yaml',
    'html',
    'scss',
    'lua',
    'typescript',
    'javascript',
    'go',
    'graphql',
  },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()

parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
