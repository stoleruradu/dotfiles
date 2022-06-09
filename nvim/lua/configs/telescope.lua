vim.g.dashboard_default_executive = 'telescope'

local telescope = require('telescope')

telescope.setup {
   defaults = {
    initial_mode = 'normal'
   }
}
telescope.load_extension('fzf')

vim.api.nvim_set_keymap('n', ';f', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';;', '<cmd>Telescope git_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';g', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';d', '<cmd>Telescope diagnostics bufnr=0<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';b', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';a', '<cmd>Telescope lsp_code_actions<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';m', '<cmd>Telescope keymaps<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';s', '<cmd>Telescope git_status<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ';r', '<cmd>Telescope lsp_references<cr>', { noremap = true })

return telescope;
