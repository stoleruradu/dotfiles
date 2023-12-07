return {
  { 'godlygeek/tabular' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = { scope = { enabled = false, show_start = false, show_end = false } },
  },
  { 'karb94/neoscroll.nvim', opts = {} },
  {
    'glepnir/lspsaga.nvim',
    branch = 'main',
    event = 'LspAttach',
    opts = {
      finder = {
        default = 'ref',
        keys = {
          vsplit = '<C-v>',
          split = '<C-s>',
        }
      },
      diagnostic = {
        max_show_width = 0.5,
        diagnostic_only_current = false,
        extend_relatedInformation = true
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
