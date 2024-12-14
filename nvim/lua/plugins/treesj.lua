return {
	"Wansmer/treesj",
	keys = {
		{ "<space>m", desc = "Toggle join or split" },
		{ "<space>j", desc = "Join" },
		{ "<space>s", desc = "Split" },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({})
	end,
}
