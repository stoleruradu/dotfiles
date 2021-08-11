" PLUGIN: FZF
nnoremap <silent> \\ :Buffers<CR>
nnoremap <silent> ;c :Commits<CR>
nnoremap <silent> ;f :Files<CR>
nnoremap <silent> ;; :GFiles<CR>
nnoremap <silent> ;r :Rg<CR>

let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:fzf_commits_log_options = '--graph --oneline --decorate --all --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:40%' --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
