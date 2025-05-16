return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			exclude = { "node_modules" },
			sources = {
				files = { ignored = true, hidden = true },
			},
		},
		dashboard = {
			preset = {
				header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
 ]],
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fw",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>fc",
			function()
				require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find config files",
		},
		{
			"<leader>fr",
			function()
				require("snacks").picker.recent()
			end,
			desc = "Find recent files",
		},
		{
			"<leader>fe",
			function()
				require("snacks").picker.icons()
			end,
			desc = "Find icons",
		},
	},
}
