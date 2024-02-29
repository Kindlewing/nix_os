return {
	{
		'L3MON4D3/LuaSnip',
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},

	{
		'hrsh7th/nvim-cmp',
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-nvim-lsp-document-symbol',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lua',
			'f3fora/cmp-spell',
			{ 'petertriho/cmp-git',       dependencies = 'nvim-lua/plenary.nvim' },
			{ 'onsails/lspkind-nvim',     dependencies = 'neovim/nvim-lspconfig' },
			{ 'saadparwaiz1/cmp_luasnip', dependencies = 'L3MON4D3/LuaSnip' },
			{ 'saecki/crates.nvim',       dependencies = 'nvim-lua/plenary.nvim' },
		},
		opts = function()
			local cmp = require('cmp')
			local defaults = require("cmp.config.default")()
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			require('luasnip.loaders.from_vscode').lazy_load()

			return {
				completion = {
					completeopt = "menu,menuone,noinsert"
				},

				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},

				window = {
					completion = {
						border = "rounded",
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
					documentation = {
						border = "rounded"
					},
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local lspkind = require('lspkind')
						local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
							vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"
						return kind
					end,
				},


				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = 'nvim_lua' },
					{ name = 'spell' },
					{ name = 'crates' },
				}, {
					{ name = "path" },
				}),
				experimental = {
					native_menu = false,
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				sorting = defaults.sorting,
			}
		end,

		config = function(_, opts)
			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end
			require("cmp").setup(opts)
		end,
	},
}
