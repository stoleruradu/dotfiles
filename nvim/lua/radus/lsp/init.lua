local nvim_lsp = require'lspconfig'
local protocol = require'vim.lsp.protocol'
local util = require 'lspconfig.util'

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap

    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! Format lua vim.lsp.buf.format { async = true }")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs Telescope lsp_references")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_map(bufnr, "n", "gd", ":LspDef<CR>", { silent = true })
    buf_map(bufnr, "n", "gR", ":LspRename<CR>", { silent = true })
    buf_map(bufnr, "n", "gr", ":LspRefs<CR>", { silent = true })
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", { silent = true })
    buf_map(bufnr, "n", "K", ":LspHover<CR>", { silent = true })
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", { silent = true })
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", { silent = true })
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", { silent = true })
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", { silent = true })
    buf_map(bufnr, "n", "<Leader><space>", ":LspDiagLine<CR>", { silent = true })
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", { silent = true })

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
        vim.api.nvim_command [[augroup END]]
    end

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
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
    root_dir = util.root_pattern("tsconfig.json", ".git")
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
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('radus.lsp.json')

return nvim_lsp
