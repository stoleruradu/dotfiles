return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        version = false, -- telescope did only one release, so use HEAD for now
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = function()
            vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', { noremap = true })
            vim.api.nvim_set_keymap('n', '<leader>.', '<cmd>Telescope keymaps<cr>', { noremap = true })
            vim.keymap.set('n', '<leader>,', '<cmd>Telescope git_status<cr>', { desc = 'Git status' })


            vim.keymap.set('n', "<leader>'", require('telescope.builtin').git_files, { desc = '[G]it [f]iles' })
            vim.keymap.set('n', '<leader>/', require('telescope.builtin').live_grep, { desc = '[F]ind [g]rep' })
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [f]iles' })
            vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
                { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader>;', require('telescope.builtin').buffers, { desc = '[F]ind [b]uffers' })
        end,
        opts = function()
            local actions = require 'telescope.actions'

            return {
                extensions = {
                    fzf = {
                        fuzzy = false,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                },
                defaults = {
                    sorting_strategy = 'ascending',
                    layout_config = {
                        prompt_position = 'top',
                        -- width = 0.5,
                        -- height = 0.4,
                    },
                    initial_mode = 'normal',
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-x>'] = false,
                            ['<C-s>'] = actions.select_horizontal,
                        },
                    },
                },
                pickers = {
                    live_grep = {
                        initial_mode = 'insert',
                    },
                    git_files = {
                        initial_mode = 'insert',
                        previewer = false,
                    },
                    buffers = {
                        initial_mode = 'insert',
                        previewer = false,
                        sorting_strategy = 'ascending',
                        mappings = {
                            n = {
                                ['<c-x>'] = actions.delete_buffer + actions.move_to_top,
                            },
                            i = {
                                ['<c-x>'] = actions.delete_buffer + actions.move_to_top,
                            }
                        }
                    }
                },
            }
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        build = 'make',
        config = function()
            require('telescope').load_extension('fzf')
        end,
    },
}
