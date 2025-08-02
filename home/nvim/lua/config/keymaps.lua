vim.api.nvim_set_keymap('', 'q', '<nop>', {})
vim.api.nvim_set_keymap('', 'ge', '<nop>', {})
vim.api.nvim_set_keymap('', 'gE', '<nop>', {})
vim.api.nvim_set_keymap('', 'gh', '<nop>', {})
vim.api.nvim_set_keymap('', 'gH', '<nop>', {})

vim.api.nvim_set_keymap('n', '<leader>0', '$', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>0', '$', { noremap = true })

vim.api.nvim_set_keymap('n', '<S-u>', '<C-r>', { noremap = true })

vim.api.nvim_set_keymap('i', '<C-c>', '<esc>', { noremap = true })

vim.api.nvim_set_keymap('t', '<esc>', '<C-\\><C-n>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>h', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-W>l', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>o', 'o<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>O', 'O<esc>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', 'Y', 'v$y', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"_dP', { noremap = true })

vim.api.nvim_set_keymap('n', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('v', 'd', '"_d', { noremap = true })
vim.api.nvim_set_keymap('x', 'd', '"_d', { noremap = true })

vim.api.nvim_set_keymap('x', 'K', ":move '<-2<cr>gv-gv", { noremap = true })
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<cr>gv-gv", { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeShow<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '-', ':Oil<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>ts', ':split | :terminal<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':vsplit | :terminal<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>=', ':vertical resize +5<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>q', '<C-W>q', { noremap = true })

vim.keymap.set('n', '<C-U>', '15<C-U>zz')
vim.keymap.set('n', '<C-D>', '15<C-D>zz')

vim.keymap.set('n', '<leader>d', function ()
  local cords = vim.api.nvim_win_get_cursor(0);
  vim.cmd('vsplit %')
  vim.api.nvim_win_set_cursor(0, cords);
end)

vim.keymap.set('n', '<leader>wo', function ()
  vim.cmd('!open %')
end)

vim.keymap.set('n', '<leader>p', function ()
  vim.cmd(':vsplit | :b#')
end)

for i = 1, 9, 1 do
  vim.keymap.set('n', '<leader>' .. i, function()
    vim.cmd('exe ' .. i .. ' .. "wincmd w"');
  end, { silent = true })
end
