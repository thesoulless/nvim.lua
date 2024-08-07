-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.x',
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
    use('ThePrimeagen/vim-be-good')
    use('mfussenegger/nvim-dap')
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    use('leoluz/nvim-dap-go')
    use('theHamsta/nvim-dap-virtual-text')
    use('navarasu/onedark.nvim')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support
			{
                'neovim/nvim-lspconfig',
                opts = {
                    inlay_hints = {
                        enabled = true,
                        show_parameter_hints = true,
                        parameter_hints_prefix = " ",
                        other_hints_prefix = " ",
                    },
                },
            },
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	}
end)
