return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			exclude = { "node_modules", "target" },
			sources = {
				files = { ignored = true, hidden = true },
				grep = {
					hidden = true,
				},
			},
		},
		dashboard = {
			sections = {
				{
					section = "terminal",
					cmd = "",
					function()
						local win_width = vim.api.nvim_win_get_width(0)
						local win_height = vim.api.nvim_win_get_height(0)

						local img_width = 20
						local img_height = 20

						local center_x = math.floor((win_width - img_width) / 2)

						local path = vim.fn.expand("~/Pictures/wallpapers/pfp/ciri.png")
						local image = require("image").from_file(path, {
							x = center_x,
							width = img_width,
							height = img_height,
						})
						vim.fn.timer_start(100, function()
							image:render()
						end)
						vim.api.nvim_create_autocmd({ "BufRead" }, {
							callback = function()
								image:clear()
							end,
						})
					end,
				},
				{
					secton = "keys",
					gap = 1,
					padding = 1,
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = " ",
						key = "s",
						desc = "Lazygit",
						action = ":lua Snacks.lazygit()",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				{ section = "startup" },
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
		{
			"<C-p>",
			function()
				require("snacks").picker.git_files()
			end,
			desc = "Find Git files",
		},
		{
			"gd",
			function()
				require("snacks").picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				require("snacks").picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				require("snacks").picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},

		-- Lazygit
		{
			"<leader>lg",
			function()
				require("snacks").lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>ll",
			function()
				require("snacks").lazygit.log()
			end,
			desc = "Lazygit logs",
		},
	},
}
