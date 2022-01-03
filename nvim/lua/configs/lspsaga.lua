local saga = require 'lspsaga'

-- nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
-- nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
-- inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
-- nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
-- 
-- nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
-- vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
saga.init_lsp_saga()
