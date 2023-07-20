local create_stack = function()
  local stack = {}

  function stack.push(item)
    table.insert(stack, item)
  end

  function stack.pop()
    return table.remove(stack)
  end

  return stack
end

local is_terminal = function(buf_name)
  return string.find(buf_name, 'term://')
end

local windows = create_stack();
local terminals = create_stack();

local command_hof = function(options)
  local vertical = options and options.vertical;

  return function()
    local closed_buffer = windows.pop()

    if vim.fn.buflisted(closed_buffer) ~= 1 then
      return
    end

    local command = vertical and ':vsplit | :buffer ' .. closed_buffer or ':buffer ' .. closed_buffer

    vim.api.nvim_command(command)
  end
end

vim.api.nvim_create_autocmd({ 'WinClosed' }, {
  callback = function(event)
    local buf_name = vim.fn.bufname(event.buf);

    if is_terminal(buf_name) then
      terminals.push(event.buf)
    end

    windows.push(event.buf)
    -- print(vim.inspect(event))
  end,
})

vim.keymap.set('n', '<leader>wP', command_hof(), { desc = 'Reopens previous closed terminal window' })
vim.keymap.set('n', '<leader>wp', command_hof({ vertical = true }),
  { desc = 'Reopens previous closed window in a vertical split' })
vim.keymap.set('n', '<leader>tp', function()
  local terminal = terminals.pop()

  if vim.fn.buflisted(terminal) ~= 1 then
    return
  end
  vim.api.nvim_command(': vsplit | :buffer ' .. terminal)
end)

local function augroup(name)
  return vim.api.nvim_create_augroup('user_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '**/node_modules/**',
  group = augroup('readonly_buffers'),
  command = 'setlocal readonly',
});

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  group = augroup('yank_enhancements'),
  callback = function(_)
    local yanked = vim.fn.getreg('0');

    vim.highlight.on_yank()
    vim.fn.setreg('+', yanked);
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})
