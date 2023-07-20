return {
  {
    'nvim-telescope/telescope.nvim',
    commit = vim.fn.has('nvim-0.9.0') == 0 and '057ee0f8783' or nil,
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    keys = function()
      vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope keymaps<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope git_status<cr>', { noremap = true })


      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [f]iles' })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind [g]rep' })
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [f]iles' })
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind [b]uffers' })
      vim.keymap.set('n', '<leader>/', function()
        require('telescope.builtin').current_buffer_fuzzy_find({
          previewer = false,
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top', width = 0.5, height = 0.4 }
        });
      end, { desc = '[/] Fuzzily search in current buffer' })
    end,
    opts = function()
      local actions = require 'telescope.actions'
      return {
        defaults = {
          initial_mode = 'insert',
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
            previewer = false,
            sorting_strategy = 'ascending',
            layout_config = {
              prompt_position = 'top',
              width = 0.5,
              height = 0.4,
            },
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
