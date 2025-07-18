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
					"rust_analyzer",
					"bashls",
					"jsonls",
					"html",
					"tailwindcss",
					"ts_ls",
					"jdtls",
					"gopls",
					"tinymist",
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"black",
					"isort",
					"prettier",
					"clang-format",
					"gofumpt",
					"golines",
					"goimports-reviser",
					"typstyle",
					"google-java-format",
					"shfmt",
					"shellcheck",
				},
			})
		end,
	},
}
