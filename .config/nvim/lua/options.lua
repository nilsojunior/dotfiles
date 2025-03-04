local opt = vim.opt

local wo = vim.wo

local autocmd = vim.api.nvim_create_autocmd

local cmd = vim.cmd

-- Relative ines
opt.relativenumber = true
opt.nu = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Colors
opt.termguicolors = true

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.updatetime = 50

-- Incremental search
opt.incsearch = true

-- Disable search highlight
opt.hlsearch = false

-- Remove case-sensitive search
opt.ignorecase = true

-- Enable case-sensitive search when using uppercase letters
opt.smartcase = true

-- Disable bottom right stuff
opt.ruler = false

-- Disable keys showing on bottom right
opt.showcmd = false

-- Highlight current line number
opt.cursorline = true
opt.cursorlineopt = "number"

-- Disable line wrapping
wo.wrap = false

-- Global statusline
opt.laststatus = 3

-- Hide mode display on bottom left
opt.showmode = false

-- Enable mouse for all modules
opt.mouse = "a"

-- Always open split on the right
opt.splitright = true

-- Always open split below
opt.splitbelow = true

opt.guicursor = ""

-- Obsidian stuff
opt.conceallevel = 2

-- Terminal Settings
autocmd("TermOpen", {
	callback = function()
		wo.number = false
		wo.relativenumber = false
		wo.scrolloff = 0
	end,
})

-- Disable statusline for toggleterm
cmd([[
    augroup ToggleTermStatusline
        autocmd!
        autocmd TermOpen * setlocal statusline=Terminal
    augroup END
]])

local function open_path(path)
	local uv = vim.loop

	local stat = uv.fs_stat(path)

	if stat.type == "directory" then
		cmd("cd " .. vim.fn.fnameescape(path))
		require("snacks").picker.files()
	elseif stat.type == "file" then
		local dir = vim.fn.fnamemodify(path, ":h")
		cmd("cd " .. vim.fn.fnameescape(dir))
		cmd("edit " .. vim.fn.fnameescape(path))
	end
end

vim.api.nvim_create_user_command("OpenWorkspace", function(opts)
	open_path(opts.args)
end, { nargs = 1, complete = "file" })
