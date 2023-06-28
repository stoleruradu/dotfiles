return {
  'hoob3rt/lualine.nvim',
  dependencies = { 'tpope/vim-fugitive' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'gruvbox',
      section_separators = { '', '' },
      component_separators = { '', '' },
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },
      lualine_x = {
        { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ',
          hint = ' ' } },
        'encoding',
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      -- lualine_a = { hello },
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = { 'fugitive' }
  }
}
