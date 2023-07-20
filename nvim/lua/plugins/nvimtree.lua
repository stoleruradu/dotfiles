return {
  'kyazdani42/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'));
    end,
    view = {
      side = 'left',
      number = true,
      relativenumber = true,
    },
    system_open = {
      -- the command to run this, leaving nil should work in most cases
      cmd = nil,
      -- the command arguments as a list
      args = {}
    },
    renderer = {
      icons = {
        glyphs = {
          git = {
            untracked = '?'
          }
        }
      }
    }
  },
}
