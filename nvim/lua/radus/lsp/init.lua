local nvim_lsp = require 'lspconfig'
local protocol = require 'vim.lsp.protocol'
local util = require 'lspconfig.util'

_G.lsp_organize_imports = function()
    local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ''
    }
    vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap

    vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
    vim.cmd('command! Format lua vim.lsp.buf.format { async = true }')
    vim.cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
    vim.cmd('command! LspHover lua vim.lsp.buf.hover()')
    vim.cmd('command! LspRename lua vim.lsp.buf.rename()')
    vim.cmd('command! LspOrganize lua lsp_organize_imports()')
    vim.cmd('command! LspRefs Telescope lsp_references')
    vim.cmd('command! LspTypeDef lua vim.lsp.buf.type_definition()')
    vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
    vim.cmd('command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()')
    vim.cmd('command! LspDiagNext lua vim.lsp.diagnostic.goto_next()')
    vim.cmd('command! LspDiagLine lua vim.diagnostic.open_float()')
    vim.cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')

    buf_map(bufnr, 'n', 'gd', ':LspDef<CR>', { silent = true })
    buf_map(bufnr, 'n', 'gr', ':Lspsaga rename<CR>', { silent = true })
    buf_map(bufnr, 'n', 'gr', ':Lspsaga lsp_finder<cr>', { silent = true })
    buf_map(bufnr, 'n', 'gy', ':LspTypeDef<CR>', { silent = true })
    buf_map(bufnr, 'n', 'K', ':Lspsaga hover_doc<CR>', { silent = true })
    buf_map(bufnr, 'n', 'gs', ':LspOrganize<CR>', { silent = true })
    buf_map(bufnr, 'n', '[a', ':LspDiagPrev<CR>', { silent = true })
    buf_map(bufnr, 'n', ']a', ':LspDiagNext<CR>', { silent = true })
    buf_map(bufnr, 'n', 'ga', ':Lspsaga code_action<CR>', { silent = true })
    buf_map(bufnr, 'n', '<Leader><space>', ':Lspsaga show_line_diagnostics<CR>', { silent = true })
    buf_map(bufnr, 'i', '<C-x><C-x>', '<cmd> LspSignatureHelp<CR>', { silent = true })

    -- if client.server_capabilities.documentFormattingProvider then
    --     vim.api.nvim_command [[augroup Format]]
    --     vim.api.nvim_command [[autocmd! * <buffer>]]
    --     vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    --     vim.api.nvim_command [[augroup END]]
    -- end

    protocol.CompletionItemKind = {
        '', -- Text
        '', -- Method
        '', -- Function
        '', -- Constructor
        '', -- Field
        '', -- Variable
        '', -- Class
        'ﰮ', -- Interface
        '', -- Module
        '', -- Property
        '', -- Unit
        '', -- Value
        '', -- Enum
        '', -- Keyword
        '﬌', -- Snippet
        '', -- Color
        '', -- File
        '', -- Reference
        '', -- Folder
        '', -- EnumMember
        '', -- Constant
        '', -- Struct
        '', -- Event
        'ﬦ', -- Operator
        '', -- TypeParameter
    }
end

nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
    filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript' },
    root_dir = util.root_pattern('tsconfig.json', '.git')
}

nvim_lsp.eslint.setup({
    -- cmd = { "vscode-eslint-language-server", "--stdio", "--ignore-pattern **/node_modules/**" },
    --settings = {
    --  options = {
    --      ignorePatterns = { "node_modules/**" }
    --  }
    --},
    root_dir = util.root_pattern(
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json'
    ),
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true

        -- vim.api.nvim_command [[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]
    end,
})

-- icon
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    severity_sort = true,
    --virtual_text = {
    --  spacing = 4,
    --  prefix = '»'
    --}
}
)

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- By default, lua-language-server doesn't have a cmd set. This is because nvim-lspconfig does not
-- make assumptions about your path. You must add the following to your init.vim or init.lua to set
-- cmd to the absolute path ($HOME and ~ are not expanded) of your unzipped and compiled lua-language-server.
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua

nvim_lsp.sumneko_lua.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
        on_attach(client, bufnr)
    end,
    settings = {
        Lua = {
            format = {
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                    indent_style = 'space',
                    indent_size = '2',
                    quote_style = 'single',
                }
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- For some reason havin setting this line below as the docs suggest
                -- open a quick-fix window every time you jump to a reference
                -- library = vim.api.nvim_get_runtime_file("", true),
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

require('radus.lsp.json')
-- require('radus.lsp.lualang')

return nvim_lsp
