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

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

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
		autocmd BufWinEnter plugins.lua 1,36fold
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
     "luukvbaal/nnn.nvim",
     config = require("nnn").setup()
   }
   use "neovim/nvim-lspconfig"
   use "hrsh7th/cmp-nvim-lsp"
   use "hrsh7th/cmp-nvim-lua"
   use "hrsh7th/cmp-buffer"
   use "hrsh7th/cmp-path"
   use "hrsh7th/cmp-cmdline"
   use "hrsh7th/nvim-cmp"
   use "L3MON4D3/LuaSnip"
   use "saadparwaiz1/cmp_luasnip"

  if packer_bootstrap then
    require("packer").sync()
  end
end)
