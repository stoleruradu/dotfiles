local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
}

-- Install your plugins here
return packer.startup(function(use)
    use { 'wbthomason/packer.nvim' } -- packer can manage itself
    use 'morhetz/gruvbox'
    use 'mbbill/undotree'
    use 'junegunn/gv.vim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'editorconfig/editorconfig-vim'
    use 'godlygeek/tabular'
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'glepnir/lspsaga.nvim'
    use 'hoob3rt/lualine.nvim'
    use 'glepnir/dashboard-nvim'

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }

    -- Git
    -- use "lewis6991/gitsigns.nvim"
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
