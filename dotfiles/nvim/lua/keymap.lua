local builtin = require('telescope.builtin')
local map = vim.keymap.set
local opts = { silent = true, noremap = true }

map({ 'n', 'x' }, '<leader>p', '"1p')

map('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
map('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write current file' })

map('n', 'H', ':bprevious<CR>', { silent = true })
map('n', 'L', ':bnext<CR>', { silent = true })
map(
	'n',
	'<leader>bd',
	'<cmd>:bdelete<CR>',
	{ desc = 'Close buffer', silent = true }
)

map('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
map('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })

map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

map(
	{ 'i', 'n' },
	'<esc>',
	'<cmd>noh<cr><esc>',
	{ desc = 'Escape and clear hlsearch' }
)

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- dap
map('n', '<leader>dc', function()
	require('dap').continue()
end, { desc = 'Continue' })
map('n', '<leader>do', function()
	require('dap').step_over()
end, { desc = 'Step over' })
map('n', '<leader>di', function()
	require('dap').step_into()
end, { desc = 'Step into' })
map('n', '<Leader>db', function()
	require('dap').toggle_breakpoint()
end, { desc = 'Toggle breakpoint' })
map({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end, { desc = 'UI hover widgets' })
map({ 'n', 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end, { desc = 'Dap UI preview' })
map('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end, { desc = 'Dap UI frames' })
map('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end, { desc = 'Dap UI scopes' })

-- telescope
map('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
map('n', '<leader>sg', builtin.live_grep, { desc = 'Search words' })
map('n', '<leader>sw', '<CMD>lua require("telescope").extensions.git_worktree.git_worktrees()<CR>',
	{ desc = "Search worktrees" });
map('n', '<leader>sc', '<CMD>lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>',
	{ desc = "Create git worktree" });
map(
	'n',
	'<leader>ss',
	builtin.lsp_document_symbols,
	{ desc = 'Search symbols (in current buffer)' }
)
map('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
map('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })

-- mason
map('n', '<leader>pm', ':Mason<CR>', { desc = 'Mason' })

-- lsp
map('n', 'K', vim.lsp.buf.hover, {})
map(
	'n',
	'<leader>ca',
	require('actions-preview').code_actions,
	{ desc = 'Code actions' }
)

local bufopts = { noremap = true, silent = true }
local buf_nmap = function(lhs, rhs, desc)
	vim.keymap.set(
		'n',
		lhs,
		rhs,
		vim.tbl_extend('force', bufopts, { desc = desc })
	)
end
local buf_map = function(lhs, rhs, modes, desc)
	vim.keymap.set(
		modes,
		lhs,
		rhs,
		vim.tbl_extend('force', bufopts, { desc = desc })
	)
end

if pcall(require, 'telescope') then
	buf_nmap(
		'gd',
		require('telescope.builtin').lsp_definitions,
		'[G]oto [D]efinition (include Declaration)'
	)
	buf_nmap(
		'gt',
		require('telescope.builtin').lsp_type_definitions,
		'[G]oto [T]ype definition'
	)
	buf_nmap(
		'gi',
		require('telescope.builtin').lsp_implementations,
		'[G]oto [I]mplementation'
	)
	buf_nmap(
		'gr',
		require('telescope.builtin').lsp_references,
		'[G]oto [R]eference'
	)
else
	buf_nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	buf_nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	buf_nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
	buf_nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	buf_nmap('gr', vim.lsp.buf.references, '[G]oto [R]eference')
end

-- git
map('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Lazygit' })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- oil
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- git
map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', opts)
map('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts)
