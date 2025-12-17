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
			-- Disable keybinds that I use for other stuff
			keymaps = {
				["<C-s>"] = false,
				["<C-p>"] = false,
			},
			columns = {
				{ "permissions", highlight = "Special" },
				{ "size", highlight = "@diff.plus" },
				{ "mtime", highlight = "@text.title" },
				{ "icon" },
			},
		})

		local keymap = vim.keymap.set
		keymap("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })
		keymap("n", "<leader>-", oil.toggle_float, { desc = "Open Oil on a floating window" })
	end,
}
