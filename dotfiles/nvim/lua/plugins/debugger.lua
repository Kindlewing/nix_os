return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'tpope/vim-fugitive',
	},
	config = function()
		require('dapui').setup()

		local dap, dapui = require('dap'), require('dapui')

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dap.adapters.php = {
			type = 'executable',
			command = 'node',
			args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' },
		}
		dap.configurations.php = {
			{
				type = 'php',
				request = 'launch',
				name = 'Listen for Xdebug',
				port = 9000,
				log = true,
			},
		}
	end,
}
