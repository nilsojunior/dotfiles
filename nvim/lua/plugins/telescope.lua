return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		keymap("n", "<leader>fw", builtin.live_grep, { desc = "Live grep" })
		keymap("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Grep current buffer" })

		require("telescope").setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
					},
				},
			},
		})
	end,
}
