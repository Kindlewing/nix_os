return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'folke/neodev.nvim',
		'folke/neoconf.nvim',
		'themaxmarchuk/tailwindcss-colors.nvim',
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		local cmp = require('cmp')
		require('neodev').setup({})
		require('neoconf').setup({})
		require('tailwindcss-colors').setup()
		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		lspconfig.nginx_language_server.setup({ capabilities = capabilities })
		lspconfig.tsserver.setup({ capabilities = capabilities })
		lspconfig.texlab.setup({ capabilities = capabilities })
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.clangd.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.cmake.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })
		lspconfig.docker_compose_language_service.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern('docker-compose.yaml'),
		})
		lspconfig.html.setup({ capabilities = capabilities })

		lspconfig.intelephense.setup({ capabilities = capabilities })
		lspconfig.dockerls.setup({
			capabilities = capabilities,
		})
		lspconfig.bashls.setup({
			capabilities = capabilities,
			filetypes = {
				'sh',
				'zsh',
			},
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
						disable = { 'missing-parameters', 'missing-fields' },
					},
				},
			},
		})
		cmp.setup.cmdline('/', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
			}, {
				{
					name = 'cmdline',
					option = {
						ignore_cmds = { 'Man', '!' },
					},
				},
			}),
		})
		-- CSS
		lspconfig.tailwindcss.setup({ capabilities = capabilities })
		capabilities.textDocument.completion.completionItem.snippetSupport =
			true

		lspconfig.cssls.setup({ capabilities = capabilities })
	end,
}
