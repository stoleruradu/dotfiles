_G.git_push_set_upstream = function()
    print('Pushing...')
    vim.api.nvim_command(':G push -u origin ' .. vim.fn.FugitiveHead())
    print('Pushed! 🤩')
end

vim.api.nvim_set_keymap('n', '<leader>ga', ':diffget //2<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':diffget //3<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gff', ':Gvdiffsplit!<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gp', ':lua git_push_set_upstream()<cr>', { noremap = true })

require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
            if vim.wo.diff then return ']h' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[h', function()
            if vim.wo.diff then return '[h' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':gitsigns stage_hunk<cr>')
        map({ 'n', 'v' }, '<leader>hr', ':gitsigns reset_hunk<cr>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<c-u>gitsigns select_hunk<cr>')
    end
}
