local saga = require('lspsaga')
local keymap = vim.keymap.set

saga.init_lsp_saga({
    code_action_lightbulb = {
        enable = false
    }
})


