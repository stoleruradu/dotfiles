-- local runtime_path = vim.split(package.path, ';')

--table.insert(runtime_path, 'lua/?.lua')
--table.insert(runtime_path, 'lua/?/init.lua')

return {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
    end,
    settings = {
        Lua = {
            format = {
                enable = true,
            },
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                -- version = 'Lua 5.1',
                version = 'LuaJIT',
                -- Setup your lua path
                --path = {
                --    '/Users/radustoleru/.nix-profile/bin/lua',
                --}
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', 'love' },
            },
            workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                -- For some reason havin setting this line below as the docs suggest
                -- open a quick-fix window every time you jump to a reference
                -- library = vim.api.nvim_get_runtime_file("", true),
                library = {
                    -- [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    -- [vim.fn.stdpath('config') .. '/lua'] = true,
                    "${3rd}/love2d/library"
                },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
