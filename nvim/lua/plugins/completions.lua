return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local ls = require("luasnip")

			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			-- Code blocks snippets by Linkarzu
			local function create_code_block_snippet(lang)
				return s({
					trig = lang,
					name = "Codeblock",
					desc = lang .. " codeblock",
				}, {
					t({ "```" .. lang, "" }),
					i(1),
					t({ "", "```" }),
				})
			end

			local languages = {
				"txt",
				"lua",
				"sql",
				"go",
				"regex",
				"bash",
				"markdown",
				"markdown_inline",
				"yaml",
				"json",
				"jsonc",
				"cpp",
				"csv",
				"java",
				"javascript",
				"python",
				"dockerfile",
				"html",
				"css",
				"templ",
				"php",
				"console",
				"rust",
			}

			local snippets = {}

			for _, lang in ipairs(languages) do
				table.insert(snippets, create_code_block_snippet(lang))
			end

			ls.add_snippets("all", snippets)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = {
							menu = 50,
							abbr = 50,
						},
						ellipsis_char = "...",
						show_labelDetails = true,

						before = function(entry, vim_item)
							return vim_item
						end,
					}),
				},

				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						scrollbar = false,
					}),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
