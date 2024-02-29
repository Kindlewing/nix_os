return {
	'nvimdev/lspsaga.nvim',
	dependencies = {
		'nvim-treesitter/nvim-treesitter', -- optional
		'nvim-tree/nvim-web-devicons', -- optional
	},
	config = function()
		require('lspsaga').setup({
			ui = {
				border = 'rounded',
				devicon = true,
			},
			lightbulb = {
				enable = false,
			},
		})

		vim.fn.sign_define({
			{
				name = 'DiagnosticSignError',
				text = '',
				texthl = 'DiagnosticSignError',
				linehl = 'ErrorLine',
			},
			{
				name = 'DiagnosticSignWarn',
				text = '',
				texthl = 'DiagnosticSignWarn',
				linehl = 'WarningLine',
			},
			{
				name = 'DiagnosticSignInfo',
				text = '',
				texthl = 'DiagnosticSignInfo',
				linehl = 'InfoLine',
			},
			{
				name = 'DiagnosticSignHint',
				text = '',
				texthl = 'DiagnosticSignHint',
				linehl = 'HintLine',
			},
		})
	end,
}
