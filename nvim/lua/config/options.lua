local opt = vim.opt
local exists = vim.fn.exists
local cmd = vim.cmd

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

cmd 'syntax on'
cmd 'filetype indent plugin on'
-- cmd 'hi normal guibg=000000'

opt.path = opt.path + '**';
opt.re = 0
opt.encoding = 'utf8'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- opt.clipboard = 'unnamedplus'

-- tell vim how many columns a tab counts for
opt.tabstop = 2
-- control how many columns vim uses when you hit Tab in insert mode
opt.softtabstop = 2
-- to control how many columns text is indented with the reindent operations (<< and >>)
opt.shiftwidth = 2
-- hitting Tab in insert mode will produce the appropriate number of spaces
opt.expandtab = true

opt.nu = true
opt.smartindent = true
opt.wrap = false
-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

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
opt.grepprg = 'rg --vimgrep --smart-case --follow'
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

if exists('&termguicolors') and exists('&winblend') then
  opt.termguicolors = true
  opt.winblend = 0
  opt.wildoptions = 'pum'
  opt.pumblend = 5
  opt.background = 'dark'
end
