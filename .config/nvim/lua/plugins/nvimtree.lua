return {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        on_attach = function(bufnr)
            local api = require('nvim-tree.api')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            vim.keymap.set("n", "d", api.fs.remove, opts "Delete")
            vim.keymap.set("n", "a", api.fs.create, opts "Create")
            vim.keymap.set("n", "y", api.fs.copy.filename, opts "Copy Name")
            vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
            vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
            vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
            vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
            vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'));
        end,
        view = {
            side = 'left',
            number = true,
            relativenumber = true,
        },
        system_open = {
            -- the command to run this, leaving nil should work in most cases
            cmd = nil,
            -- the command arguments as a list
            args = {}
        },
        renderer = {
            icons = {
                glyphs = {
                    git = {
                        untracked = '?'
                    }
                }
            }
        }
    },
}
