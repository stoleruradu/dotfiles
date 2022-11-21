-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end

    return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, 'packer')

if not status then
    return
end

return packer.startup(function(use)
    -- Install your plugins here
    use { 'wbthomason/packer.nvim' } -- packer can manage itself

    use 'morhetz/gruvbox'

    use 'mbbill/undotree'

    use 'junegunn/gv.vim'

    use 'nvim-lua/plenary.nvim'

    use 'kyazdani42/nvim-web-devicons'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use 'godlygeek/tabular'

    use 'hrsh7th/nvim-compe'

    use 'hoob3rt/lualine.nvim'

    use 'glepnir/dashboard-nvim'

    -- LSP
    use 'neovim/nvim-lspconfig' -- enable LSP

    -- Telescope
    use 'nvim-telescope/telescope.nvim'

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
        end,
    }

    use { 'tpope/vim-fugitive' }

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    -- use 'airblade/vim-gitgutter'
    use 'lukas-reineke/indent-blankline.nvim'

    use 'karb94/neoscroll.nvim'

    use({
        'glepnir/lspsaga.nvim',
        branch = 'main'
    })

    use { 'williamboman/mason.nvim' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        packer.sync()
    end
end)
