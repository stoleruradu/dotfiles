return {
  { 'godlygeek/tabular' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = { scope = { enabled = false, show_start = false, show_end = false } },
  },
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
