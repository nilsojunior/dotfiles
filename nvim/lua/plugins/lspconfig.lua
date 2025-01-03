return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})
		lspconfig.pyright.setup({
			capabilities = capabilities,
		})
		lspconfig.clangd.setup({
			capabilities = capabilities,
		})
		-- lspconfig.cssls.setup({
		-- 	capabilities = capabilities,
		-- 	settings = {
		-- 		css = {
		-- 			lint = {
		-- 				unknownAtRules = "ignore",
		-- 				invalidPropertyValue = "ignore",
		-- 			},
		-- 		},
		-- 	},
		-- })
		lspconfig.stylelint_lsp.setup({
			capabilities = capabilities,
		})
		lspconfig.bashls.setup({
			capabilities = capabilities,
		})
		local keymap = vim.keymap.set

		keymap("n", "K", vim.lsp.buf.hover, {})
		keymap("n", "gd", vim.lsp.buf.definition, {})
		keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" }, {})
		keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" }, {})
	end,
}
