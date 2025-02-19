return {
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
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
