_G.git_push_set_upstream = function()
  print('Pushing...')

  local branch = vim.fn.FugitiveHead()
  vim.api.nvim_command(':G push -u origin ' .. branch)

  print('Pushed! 🤩')
end

_G.git_reset_hard_origin = function()
  local branch = vim.fn.FugitiveHead()

  vim.api.nvim_command(':G fetch origin')
  vim.api.nvim_command(':G reset --hard origin/' .. branch)
end

vim.api.nvim_set_keymap('n', '<leader>ga', ':diffget //2<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':diffget //3<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gff', ':Gvdiffsplit!<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gv', ':GV<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gp', ':lua git_push_set_upstream()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gbr', ':lua git_reset_hard_origin()<cr>', { noremap = true })

return {
  { 'junegunn/gv.vim' },
  { 'tpope/vim-fugitive' },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = buffer
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
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<cr>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<cr>')

        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hs', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>')
      end
    }
  },
}
