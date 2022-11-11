local M = {}

M.pushSetUpstream = function()
    print('Pushing...')
    vim.api.nvim_command(':G push -u origin ' .. vim.fn.FugitiveHead())
    print('Pushed! 🤩')
end

return M
