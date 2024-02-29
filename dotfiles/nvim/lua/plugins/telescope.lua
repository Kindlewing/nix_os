return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.4',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local actions = require('telescope.actions')

		require('telescope').setup({
			defaults = {
				mappings = {
					i = {
						['esc'] = actions.close,
					},
				},
				file_ignore_patterns = {
					'codegen.ts',
					'.git/',
					'lazy-lock.json',
					'node_modules/',
					'target/',
					'vendor/',
					'build/',
					'.venv/',
					'.cache/',
					'*.o',
				},
				dynamic_preview_title = true,
				path_display = { 'smart' },
			},
			pickers = {
				find_files = {
					follow = true,
					hidden = true,
					no_ignore = true,
				},
			},
		})
	end,
}
