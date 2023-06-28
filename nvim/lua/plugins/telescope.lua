return {
  { 'nvim-telescope/telescope.nvim',
    commit = vim.fn.has('nvim-0.9.0') == 0 and '057ee0f8783' or nil,
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fG', '<cmd>Telescope git_files<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope keymaps<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope git_status<cr>', { noremap = true })
    end,
    opts = function()
      local actions = require 'telescope.actions'
      return {
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
    end,
  },
  {
    'telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
  },
}
