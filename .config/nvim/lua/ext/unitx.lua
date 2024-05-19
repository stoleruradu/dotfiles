local M = {};

local entries = {};

local signs_group = 'UnitxSigns';

local dirname = function(str)
    if str:match(".-/.-") then
        local name = string.gsub(str, "(.*/)(.*)", "%1")
        return name
    else
        return ''
    end
end

local filename = function(str)
    if str:match(".-/.-") then
        local name = string.gsub(str, "(.*/)(.*)", "%2")
        return name
    else
        return ''
    end
end

local init_ui = function()
    local neutral_green = '#98971a';
    local signs = { Start = ' ', Stop = '■ ', }

    vim.api.nvim_set_hl(0, "UnitxSignsGreen", {fg = neutral_green})

    for type, icon in pairs(signs) do
        local hl = signs_group .. type
        vim.fn.sign_define(hl, { text = icon, texthl = 'UnitxSignsGreen', numhl = hl })
    end
end

local get_tests = function(bufnr)
    local query = vim.treesitter.query.parse('typescript', [[
        (expression_statement
            (call_expression
                function: (identifier) @fn.name (#any-of? @fn.name "describe" "it" "test")
                arguments: [
                    (arguments (string (string_fragment) @test.name))
                    (arguments (member_expression object: (identifier) @test.name property: (property_identifier) @class.property (#eq? @class.property "name")))
                    (arguments
                        (member_expression
                            object:
                            (member_expression
                                 object: (member_expression object: (identifier) property: (property_identifier) @class.proto (#eq? @class.proto "prototype"))
                                 property: (property_identifier) @test.name
                            )
                        )
                    )
            ])
        )
    ]]);

    local parser = vim.treesitter.get_parser(bufnr, 'typescript');
    local tree = unpack(parser:parse());
    local tests = {};

    vim.fn.sign_unplace(signs_group, { buffer = bufnr });

    for id, node in query:iter_captures(tree:root(), bufnr, 0, -1) do
        local name = query.captures[id];

        if name == 'test.name' then
            local test = {};
            local row = node:range();

            test.lnum = row + 1;
            test.name = vim.treesitter.get_node_text(node, bufnr);

            function test:run(path)
                vim.cmd ':vsplit';
                vim.cmd ':terminal';

                local cmd = { "npm test", "--", "-i", path, "-t", string.format('"%s"', self.name), "\r" };

                vim.defer_fn(function()
                    vim.api.nvim_chan_send(vim.bo.channel, table.concat(cmd, " "))
                end, 500);
            end

            table.insert(tests, test)
            vim.fn.sign_place(0, signs_group, 'UnitxSignsStart', bufnr, { lnum = test.lnum })
        end
    end

    return tests;
end

local load_spec_buf = function(bufnr)
    local path = vim.api.nvim_buf_get_name(bufnr);

    if entries[path] then
        return entries[path];
    end

    local entry = {};

    function entry:reload()
        self.tests = get_tests(self.buf);
    end

    entry.buf = bufnr;
    entry.path = path;
    entry.cwd = dirname(path);
    entry.filename = filename(path);
    entry.tests = get_tests(bufnr);

    vim.keymap.set('n', '<leader>r', function()
        local cords = vim.api.nvim_win_get_cursor(0);
        local row = unpack(cords);

        for _, test in pairs(entry.tests) do
            if test.lnum == row then
                test:run(string.sub(entry.filename, 1, -3)); -- TODO: this should be entry.path
            end
        end
    end, { silent = true, buffer = entry.buf })

    entries[path] = entry;

    return entry;
end
local init_autocmd = function()
    local function augroup(name)
        return vim.api.nvim_create_augroup('Nodejs' .. name, { clear = true })
    end

    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
        pattern = { "*.test.ts", "*.spec.ts" },
        group = augroup('Unitx'),
        callback = function(event)
            local entry = load_spec_buf(event.buf);

            if event.event == 'BufWritePost' then
                entry:reload();
            end
        end,
    });
end

M.setup = function()
    init_ui();
    init_autocmd();
end

return M;
