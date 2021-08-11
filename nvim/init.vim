syntax on

filetype indent plugin on

set path+=**
set re=0
set encoding=utf8

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nu
set smartindent
set nowrap
set smartcase
set noswapfile
set nobackup
set undofile
set incsearch
set relativenumber
set colorcolumn=160
set backspace=indent,eol,start
set cmdheight=2
set updatetime=300
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" set guifont=DroidSansMono_Nerd_Font:h11
set splitbelow splitright
set cursorline
set shortmess+=c

set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" Fix Sizing Bug With Alacritty Terminal
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

" Plug init
runtime ./plug.vim

" true color
if exists("&termguicolors") && exists("&winblend")
    set termguicolors
    set winblend=0
    set wildoptions=pum
    set pumblend=5
    set background=dark

    colorscheme gruvbox
endif

let mapleader = " "

map q <nop>

nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l

nnoremap <leader>w <C-W>q
nnoremap <S-u> <C-r>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

nnoremap <silent> <Leader>t :split \| :terminal<CR>
nnoremap <silent> <Leader>tt :vsplit \| :terminal<CR>

nmap <silent> <Leader>= :vertical resize +5<CR>
nmap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <C-s> :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>, :vsplit ~/.config/nvim/init.vim<CR>

nnoremap <leader>p "+p
vnoremap <leader>p "+p

nnoremap <leader>y "+y
vnoremap <leader>y "+y

vnoremap <leader>p "_dP

nnoremap Y v$y

nnoremap d "_d
vnoremap d "_d

xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

tnoremap <Esc> <C-\><C-n>

inoremap <C-c> <esc>
inoremap ii <Esc>

" Remove search highlight
nnoremap <silent> <leader>/ :noh<CR>

lua require('plugin/lualine')
lua require('plugin/treesitter')
lua require('plugin/lsp-config')
lua require('plugin/compe') 
lua require('plugin/code-actions')

