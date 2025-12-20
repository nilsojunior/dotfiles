local defaults = {
	rust = function()
		return "cargo run"
	end,
	sh = function()
		return vim.fn.expand("%")
	end,
}

local term = {
	win = -1,
	buf = -1,
	cmd = nil,
	default = function()
		return defaults[vim.bo.filetype]()
	end,
}

local keymap = vim.keymap.set

local function run_cmd()
	local cmd = term.cmd

	if not cmd then
		cmd = term.default()
	elseif not cmd then
		vim.notify(string.format("No default command for filetype: %s", vim.bo.filetype), vim.log.levels.WARN)
		return
	end

	term.buf = vim.api.nvim_create_buf(true, true)
	term.win = vim.api.nvim_open_win(term.buf, true, {
		split = "below",
	})

	local shell_cmd = string.format("run_cmd.sh '%s'", cmd)
	vim.fn.jobstart(shell_cmd, {
		term = true,
		on_stdout = function()
			if vim.api.nvim_get_current_buf() == term.buf then
				vim.cmd("startinsert")
			end
		end,
		-- Avoid the process exited message
		on_exit = function()
			vim.api.nvim_buf_delete(term.buf, {})
		end,
	})

	keymap("t", "<ESC>", "<C-\\><C-n>", {
		buffer = term.buf,
		noremap = true,
		silent = true,
	})
end

local function create_win()
	local buf = vim.api.nvim_create_buf(true, true)

	local win = vim.api.nvim_open_win(buf, true, {
		split = "below",
		height = 1,
	})
	vim.api.nvim_set_option_value("number", false, { win = win })
	vim.api.nvim_set_option_value("relativenumber", false, { win = win })
	vim.api.nvim_set_option_value("filetype", "sh", { buf = buf })

	vim.cmd("startinsert")

	keymap({ "i", "n" }, "<CR>", function()
		term.cmd = vim.api.nvim_get_current_line()
		run_cmd()
		vim.api.nvim_win_close(win, false)
		vim.cmd("stopinsert")
	end, {
		buffer = buf,
		noremap = true,
		silent = true,
	})
end

local function toggle_term()
	if vim.api.nvim_win_is_valid(term.win) then
		vim.api.nvim_win_hide(term.win)
		return
	end

	term.win = vim.api.nvim_open_win(term.buf, false, {
		split = "below",
	})
end

keymap("n", "<leader>re", create_win)
keymap("n", "<leader>rw", run_cmd)
keymap("n", "<leader>ru", toggle_term)
