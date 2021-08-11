" GIT
nnoremap <leader>gh :diffget //3<CR>
nnoremap <leader>gu :diffget //2<CR>
nnoremap <leader>gs :G<CR>

function! GitPushSetUpstream() abort
  echo "Pushing..."
  exe 'G push -u origin ' . FugitiveHead()
  echo "Pushed! 🤩"
endfunction

nmap <silent> <leader>gp :call GitPushSetUpstream()<CR>
