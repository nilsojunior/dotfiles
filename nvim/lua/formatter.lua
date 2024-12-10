local command = vim.api.nvim_command

local notify = vim.notify

local warn = vim.log.levels.WARN

local autocmd = vim.api.nvim_create_autocmd

local function format_file()
	local filetype = vim.bo.filetype
	local cmd = nil

	if filetype == "lua" then
		cmd = "stylua %"
	elseif filetype == "python" then
		cmd = "black % && isort %"
	elseif filetype == "markdown" then
		cmd = "prettier --write %"
	elseif filetype == "c" or filetype == "cpp" or filetype == "h" then
		cmd = "clang-format -i %"
	else
		notify("No formatter found for ." .. filetype .. " files", warn)
		return
	end

	command("silent! write") -- Save
	command("silent! !" .. cmd) -- Run formatter
	command("edit") -- Reload file
end

-- Format on save
autocmd("BufWritePost", {
	callback = format_file,
})
