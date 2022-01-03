local cmd = vim.cmd
local opt = vim.opt

cmd 'syntax on'
cmd 'filetype indent plugin on'

opt.path = opt.path + '**';
opt.re = 0
opt.encoding = 'utf8'
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.nu = true
opt.smartindent = true
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.incsearch = true
opt.list = true
opt.listchars = 'tab:▸ ,trail:·'
opt.relativenumber = true
opt.colorcolumn = '80'
opt.backspace = 'indent,eol,start'
opt.cmdheight = 2
opt.updatetime = 300
opt.grepprg = "rg --vimgrep --smart-case --follow"
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true
opt.shortmess = opt.shortmess + 'c'
opt.wildignore:append({
    '**/coverage/*',
    '**/node_modules/*',
    '**/android/*',
    '**/ios/*',
    '**/.git/*'
})

cmd [[
    hi! Normal ctermbg=NONE guibg=NONE 
    hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
    "  Fix Sizing Bug With Alacritty Terminal
    autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
]]

require('plugins')

cmd [[
if exists("&termguicolors") && exists("&winblend")
    set termguicolors
    set winblend=0
    set wildoptions=pum
    set pumblend=5
    set background=dark

    colorscheme gruvbox
endif
]]

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('', 'q', '<nop>', {})
vim.api.nvim_set_keymap('n', '<S-u>', '<C-r>', { noremap = true })

vim.api.nvim_set_keymap('i', '<C-c>', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'ii', '<esc>', { noremap = true })

vim.api.nvim_set_keymap('t', '<esc>', '<C-\\><C-n>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>h', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-W>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', '<C-W>q', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>o', 'o<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>O', 'O<esc>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', 'Y', 'v$y', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"_dP', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>d', '"_d', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>d', '"_d', { noremap = true })

vim.api.nvim_set_keymap('x', 'K', ":move '<-2<cr>gv-gv", { noremap = true })
vim.api.nvim_set_keymap('x', 'J', ":move '>+1<cr>gv-gv", { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeShow<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>t', ':split | :terminal<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tt', ':vsplit | :terminal<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>=', ':vertical resize +5<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>/', ':noh<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-s>', ':source ~/.config/nvim/init.lua<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>,', ':vsplit ~/.config/nvim/init.lua<cr>', { noremap = true })

require('configs.compe')
require('configs.lspconfig')
require('configs.lualine')
require('configs.nvimtree')
require('configs.treesitter')
require('configs.telescope')
-- require('plugins.configs.lspsaga') // lspsaga is bugy on neovim 0.6.0
