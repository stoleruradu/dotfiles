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
vim.api.nvim_set_keymap('n', '<leader>wq', '<C-W>q', { noremap = true })
