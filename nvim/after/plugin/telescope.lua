local telescope = require('telescope')

telescope.setup {
  defaults = {
    initial_mode = 'normal'
  },
}

telescope.load_extension('fzf')

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files theme=ivy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fG', '<cmd>Telescope git_files theme=ivy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep theme=ivy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics bufnr=0 theme=ivy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers theme=ivy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope keymaps theme=ivy<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope git_status theme=ivy<cr>', { noremap = true })

return telescope;
