local opt = vim.opt
local exists = vim.fn.exists
local cmd = vim.cmd

cmd 'syntax on'
cmd 'filetype indent plugin on'
-- cmd 'hi normal guibg=000000'

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
opt.colorcolumn = '110'
opt.completeopt = 'menuone,noselect'
opt.backspace = 'indent,eol,start'
opt.cmdheight = 1
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

if exists("&termguicolors") and exists("&winblend") then
    opt.termguicolors = true
    opt.winblend = 0
    opt.wildoptions = 'pum'
    opt.pumblend = 5
    opt.background = 'dark'
    cmd 'colorscheme gruvbox'
end
