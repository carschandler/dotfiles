local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require("packer")

packer.init {
	display = {
		open_fn = require("packer.util").float,
	},
}

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
	augroup fold_plugins_lua
		autocmd!
		autocmd BufWinEnter plugins.lua 1,31fold
	augroup end
]])

return packer.startup(function(use)
  -- Packer can manage itself
   use "wbthomason/packer.nvim"
   use "nvim-lua/popup.nvim"
   use "nvim-lua/plenary.nvim"
   use "ellisonleao/gruvbox.nvim"
   use "jeffkreeftmeijer/vim-numbertoggle"
   use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
         -- LSP Support
         {'neovim/nvim-lspconfig'},             -- Required
         {'williamboman/mason.nvim'},           -- Optional
         {'williamboman/mason-lspconfig.nvim'}, -- Optional

         -- Autocompletion
         {'hrsh7th/nvim-cmp'},         -- Required
         {'hrsh7th/cmp-nvim-lsp'},     -- Required
         {'hrsh7th/cmp-buffer'},       -- Optional
         {'hrsh7th/cmp-path'},         -- Optional
         {'hrsh7th/cmp-cmdline'},      -- Added
         {'saadparwaiz1/cmp_luasnip'}, -- Optional
         {'hrsh7th/cmp-nvim-lua'},     -- Optional

         -- Snippets
         {'L3MON4D3/LuaSnip'},             -- Required
         {'rafamadriz/friendly-snippets'}, -- Optional
      }
   }


   if packer_bootstrap then
      require("packer").sync()
   end
end)
