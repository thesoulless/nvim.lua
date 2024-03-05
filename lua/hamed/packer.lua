-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
	})


	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('fatih/vim-go', { run = ':GoUpdateBinaries' })
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')
    use('github/copilot.vim')
    use('tpope/vim-obsession')
    use('mattn/vim-goimports')
    use('ray-x/lsp_signature.nvim')
    -- use('hrsh7th/vim-vsnip')
    -- use('hrsh7th/vim-vsnip-integ')
    use('nvim-treesitter/nvim-treesitter-context')
    use('ThePrimeagen/git-worktree.nvim')
    use('nvim-lua/popup.nvim')
    use('nvim-telescope/telescope-fzy-native.nvim')
    use('tpope/vim-commentary')
    use('editorconfig/editorconfig-vim')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}
end)
