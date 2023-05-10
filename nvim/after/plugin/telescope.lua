local actions = require 'telescope.actions'
local telescope = require 'telescope'

telescope.setup {
  defaults = {
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-x>'] = false,
        ['<C-s>'] = actions.select_horizontal,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['<c-x>'] = actions.delete_buffer + actions.move_to_top,
        },
        i = {
          ['<c-x>'] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  },
}

telescope.load_extension 'fzf'

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fG', '<cmd>Telescope git_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope keymaps<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope git_status<cr>', { noremap = true })

return telescope;
