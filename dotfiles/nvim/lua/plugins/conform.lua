return {
	'stevearc/conform.nvim',
	lazy = true,
	event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
	config = function()
		local slow_format_filetypes = {}
		require('conform').setup({
			formatters_by_ft = {
				lua = { 'stylua' },
				c = { 'clang_format' },
				cpp = { 'clang_format' },
				nix = { 'nixpkgs-format' },
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
				css = { 'prettier' },
				html = { 'prettier' },
				json = { 'prettier' },
				yaml = { 'prettier' },
				markdown = { 'prettier' },
				php = { 'php_cs_fixer' },
			},

			format_on_save = function(bufnr)
				if slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				local function on_format(err)
					if err and err:match('timeout$') then
						slow_format_filetypes[vim.bo[bufnr].filetype] = true
					end
				end

				return { timeout_ms = 200, lsp_fallback = true }, on_format
			end,

			format_after_save = function(bufnr)
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_fallback = true }
			end,
		})
	end,
}
