return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		local oil = require("oil")
		oil.setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
			-- Disable keybinds that i use for other stuff
			keymaps = {
				["<C-s>"] = false,
				["<C-p>"] = false,
			},
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
