return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
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
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"jsx",
				},
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.tinymist.setup({
				capabilities = capabilities,
			})
			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})

			local keymap = vim.keymap.set

			keymap("n", "K", vim.lsp.buf.hover, {})
			keymap("n", "gd", vim.lsp.buf.definition, {})
			keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
			keymap("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Diagnostic" })
			keymap("n", "<leader>[d", vim.diagnostic.get_prev, { desc = "Next diagnostic" })
			keymap("n", "<leader>]d", vim.diagnostic.get_next, { desc = "Prev diagnostic" })
			keymap("n", "<leader>rm", vim.lsp.buf.rename, { desc = "Rename" })
			keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
		end,
	},
}
