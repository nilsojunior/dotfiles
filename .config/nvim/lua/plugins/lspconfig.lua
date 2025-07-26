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
							globals = { "vim" },
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
					-- Buffer local mappings
					-- Check `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }

					local keymap = vim.keymap.set

					keymap("n", "K", vim.lsp.buf.hover, opts)

					opts.desc = "Diagnostic"
					keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)

					opts.desc = "Prev diagnostic"
					keymap("n", "]d", vim.diagnostic.goto_prev, opts)

					opts.desc = "Next diagnostic"
					keymap("n", "[d", vim.diagnostic.goto_next, opts)

					opts.desc = "Rename"
					keymap("n", "<leader>rm", vim.lsp.buf.rename, opts)

					opts.desc = "Code actions"
					keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

					keymap("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, opts)

					-- Snacks
					local snacks = require("snacks")

					opts.desc = "Goto Definition"
					keymap("n", "gd", snacks.picker.lsp_definitions, opts)

					opts.desc = "Goto Declaration"
					keymap("n", "gD", snacks.picker.lsp_declarations, opts)

					opts.desc = "References"
					opts.nowait = true
					keymap("n", "gr", snacks.picker.lsp_references, opts)

					opts.desc = "Diagnostics"
					keymap("n", "<leader>ds", snacks.picker.diagnostics, opts)

					opts.desc = "Buffer diagnostics"
					keymap("n", "<leader>db", snacks.picker.diagnostics_buffer, opts)
				end,
			})

			-- Define sign icons for each severity
			local signs = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "󰠠 ",
				[vim.diagnostic.severity.INFO] = " ",
			}
			-- Set the diagnostic config with all icons
			vim.diagnostic.config({
				signs = {
					text = signs, -- Enable signs in the gutter
				},
				virtual_text = true, -- Specify Enable virtual text for diagnostics
				underline = true, -- Specify Underline diagnostics
				update_in_insert = false, -- Keep diagnostics active in insert mode
			})
		end,
	},
}
