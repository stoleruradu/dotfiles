if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'mbbill/undotree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " Highlighting Nerdtree
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'godlygeek/tabular'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'RishabhRD/popfix'
    Plug 'RishabhRD/nvim-lsputils'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'hoob3rt/lualine.nvim'
call plug#end()

