return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
			},
			pickers = {
				find_files = {
					file_ignore_patterns = {
						"node_modules",
						".git",
						".venv",
					},
					hidden = true,
				},
			},
			extensions = {
				fzf = {},
			},
		})
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		keymap("n", "<leader>fw", builtin.live_grep, { desc = "Live grep" })
		keymap("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer" })
		keymap("n", "<leader>fo", builtin.oldfiles, { desc = "Find oldfiles" })
	end,
}
