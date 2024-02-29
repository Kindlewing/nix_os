local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
require('icons')
require('base')
require('lazy').setup('plugins')

vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_float_style = 'dim'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

-- vim.cmd.colorscheme('tokyodark')
vim.cmd.colorscheme('gruvbox-material')
-- vim.cmd.colorscheme('catppuccin')

require('keymap')
require('highlights')
require('register-keys')
