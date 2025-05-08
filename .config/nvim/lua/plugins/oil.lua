return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		local oil = require("oil")
		oil.setup({
			default_file_explorer = true,
		})

		local keymap = vim.keymap.set
		keymap("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })
		keymap("n", "<A-->", oil.toggle_float, { desc = "Open Oil on a floating window" })

		-- Enable cursorline on Oil
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "oil",
			callback = function()
				vim.opt_local.cursorline = true
				vim.opt_local.cursorlineopt = "line"
			end,
		})
	end,
}
