" GIT
let g:gitgutter_sign_allow_clobber = 1

nnoremap <leader>ga :diffget //2<CR> " fetches the hunk from the target parent (on the left)
nnoremap <leader>gd :diffget //3<CR> " fetches the hunk from the merge parent (on the right)
nnoremap <leader>gff :Gvdiffsplit!<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>gw :Gwrite<CR>

function! GitPushSetUpstream() abort
  echo "Pushing..."
  exe 'G push -u origin ' . FugitiveHead()
  echo "Pushed! 🤩"
endfunction

nmap <silent> <leader>gp :call GitPushSetUpstream()<CR>
