return {
  { 'godlygeek/tabular' },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = false,
      show_current_context_start = false,
    }
  },
  { 'karb94/neoscroll.nvim', opts = {} },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
      { '<leader>1',  '<Cmd>BufferLineGoToBuffer 1<CR>',         desc = 'Jump to visible buffer 1' },
      { '<leader>2',  '<Cmd>BufferLineGoToBuffer 2<CR>',         desc = 'Jump to visible buffer 2' },
      { '<leader>3',  '<Cmd>BufferLineGoToBuffer 3<CR>',         desc = 'Jump to visible buffer 3' },
      { '<leader>4',  '<Cmd>BufferLineGoToBuffer 4<CR>',         desc = 'Jump to visible buffer 4' },
      { '<leader>5',  '<Cmd>BufferLineGoToBuffer 5<CR>',         desc = 'Jump to visible buffer 5' },
      { '<leader>6',  '<Cmd>BufferLineGoToBuffer 6<CR>',         desc = 'Jump to visible buffer 6' },
      { '<leader>7',  '<Cmd>BufferLineGoToBuffer 7<CR>',         desc = 'Jump to visible buffer 7' },
      { '<leader>8',  '<Cmd>BufferLineGoToBuffer 8<CR>',         desc = 'Jump to visible buffer 8' },
      { '<leader>9',  '<Cmd>BufferLineGoToBuffer 9<CR>',         desc = 'Jump to visible buffer 9' },
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>',            desc = 'Toggle pin' },
      { '<leader>bo', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    },
    opts = {
      options = {
        numbers = function(opts)
          return string.format('%s|', opts.ordinal);
        end,
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'left',
            highlight = 'Directory',
          }
        },
      }
    }
  },
  {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    event = 'LspAttach',
    opts = {
      finder = {
        keys = {
          vsplit = '<C-v>',
          split = '<C-s>',
        }
      },
      ui = {
        colors = {
          --float window normal background color
          -- normal_bg = '#1d1536',
          normal_bg = '#282828',
          --title background color
          --title_bg = '#afd700',
          --red = '#e95678',
          --magenta = '#b33076',
          --orange = '#FF8700',
          --yellow = '#f7bb3b',
          --green = '#afd700',
          --cyan = '#36d0e0',
          --blue = '#61afef',
          --purple = '#CBA6F7',
          --white = '#d1d4cf',
          --black = '#1c1c19',
        },
      },
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
    }
  }
}
