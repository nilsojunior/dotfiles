local cmd

local keymap = vim.keymap.set

local function run_cmd()
	if not cmd or cmd:match("^%s*$") then
		vim.notify("There is no command to run", vim.log.levels.WARN)
		return
	end

	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_open_win(buf, true, {
		split = "below",
	})

	local shell_cmd = string.format("tmux.sh '%s'", cmd)
	vim.fn.jobstart(shell_cmd, {
		term = true,
		on_stdout = function()
			vim.cmd("startinsert")
		end,
		-- Avoid the process exited message
		on_exit = function()
			vim.api.nvim_buf_delete(buf, {})
		end,
	})

	keymap("t", "<ESC>", "<C-\\><C-n>", {
		buffer = buf,
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
		cmd = vim.api.nvim_get_current_line()
		run_cmd()
		vim.api.nvim_win_close(win, false)
		vim.cmd("stopinsert")
	end, {
		buffer = buf,
		noremap = true,
		silent = true,
	})
end

keymap("n", "<leader>re", create_win)
keymap("n", "<leader>rw", run_cmd)
