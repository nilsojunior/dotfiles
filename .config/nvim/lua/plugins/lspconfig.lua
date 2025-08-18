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
				settings = {
					Lua = {
						diagnostics = {
							globals = { "pandoc" },
						},
					},
				},
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})
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

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local function keymap(mode, map, func, desc, nowait)
						vim.keymap.set(mode, map, func, {
							buffer = ev.buf,
							silent = true,
							desc = "LSP: " .. desc,
							nowait = nowait,
						})
					end
					keymap("n", "K", vim.lsp.buf.hover, "Docs")

					keymap("n", "<leader>vd", vim.diagnostic.open_float, "Diagnostic")

					keymap("n", "]d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, "Prev diagnostic")

					keymap("n", "[d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, "Next diagnostic")

					keymap("n", "<leader>rm", vim.lsp.buf.rename, "Rename")

					keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")

					keymap({ "i", "n" }, "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, "Signature docs")

					-- Snacks
					local snacks = require("snacks")

					keymap("n", "gd", snacks.picker.lsp_definitions, "Goto Definition")

					keymap("n", "gD", snacks.picker.lsp_declarations, "Goto Declaration")

					keymap("n", "gr", snacks.picker.lsp_references, "References", true)

					keymap("n", "<leader>ds", snacks.picker.diagnostics, "Diagnostics")

					keymap("n", "<leader>db", snacks.picker.diagnostics_buffer, "Buffer diagnostics")
				end,
			})

			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},

					-- Highlight line numbers where diagnostic exist
					numhl = {
						[vim.diagnostic.severity.ERROR] = "ErrorMsg",
						[vim.diagnostic.severity.WARN] = "WarningMsg",
					},
				},
				virtual_text = true,
				-- virtual_lines = true,
				underline = true, -- Specify Underline diagnostics
				update_in_insert = false, -- Keep diagnostics active in insert mode
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					header = "",
					prefix = "",
					source = true,
				},
			})
		end,
	},
}
