local cmd
local win
local buf

local keymap = vim.keymap.set

local function run_cmd()
	if not cmd or cmd:match("^%s*$") then
		vim.notify("There is no command to run", vim.log.levels.WARN)
		return
	end
	vim.fn.system("tmux.sh '" .. cmd .. "'")
end

local function create_win()
	if buf then
		vim.api.nvim_buf_attach(buf, false, {})
	else
		buf = vim.api.nvim_create_buf(true, true)
	end

	win = vim.api.nvim_open_win(buf, true, {
		split = "below",
		height = 1,
	})
	vim.api.nvim_set_option_value("number", false, { win = win })
	vim.api.nvim_set_option_value("relativenumber", false, { win = win })
	vim.api.nvim_set_option_value("filetype", "sh", { buf = buf })
	vim.api.nvim_feedkeys("A", "n", false)

	keymap({ "i", "n" }, "<CR>", function()
		cmd = vim.api.nvim_get_current_line()
		run_cmd()
		vim.api.nvim_win_close(win, false)
		vim.api.nvim_command("stopinsert")
	end, { buffer = buf, noremap = true, silent = true })
end

keymap("n", "<leader>re", create_win)
keymap("n", "<leader>rw", run_cmd, {})
