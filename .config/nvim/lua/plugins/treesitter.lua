return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_install = true,
				ensure_installed = {
					"lua",
					"python",
					"c",
					"cpp",
					"markdown",
					"json",
					"yaml",
					"toml",
					"rust",
					"bash",
					"css",
					"java",
					"go",
					"typst",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		layz = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.inner",
							["il"] = "@loop.inner",
						},
					},
				},
			})
		end,
	},
}
