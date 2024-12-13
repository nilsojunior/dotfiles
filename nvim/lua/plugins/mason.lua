return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"clangd",
					"stylelint_lsp",
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"black",
					"isort",
					"prettier",
					"clang-format",
				},
			})
		end,
	},
}
