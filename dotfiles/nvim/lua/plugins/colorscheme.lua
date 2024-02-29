return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false,
		priority = 1000,
		opts = {
			integrations = {
				cmp = true,
				gitsigns = true,
				harpoon = true,
				illuminate = true,
				indent_blankline = {
					enabled = false,
					scope_color = 'sapphire',
					colored_indent_levels = false,
				},
				mason = true,
				native_lsp = { enabled = true },
				notify = true,
				nvimtree = true,
				neotree = true,
				symbols_outline = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
			},
		},
	},
	{
		'tiagovla/tokyodark.nvim',
		opts = {
			-- custom options here
		},
		config = function(_, opts)
			require('tokyodark').setup(opts) -- calling setup is optional
		end,
	},
	{
		'sainnhe/gruvbox-material',
	},
}
