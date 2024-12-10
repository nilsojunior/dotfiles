local opt = vim.opt

local keymap = vim.keymap

local wo = vim.wo

local autocmd = vim.api.nvim_create_autocmd

local cmd = vim.cmd

vim.g.mapleader = " "

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

-- Disable bottom right stuff
opt.ruler = false

-- Disable keys showing on bottom right
opt.showcmd = false

-- Highlight current line number
opt.cursorline = true
opt.cursorlineopt = "number"

wo.wrap = false

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

-- Run current python file
autocmd("FileType", {
	pattern = "python",
	callback = function()
		keymap.set(
			"n",
			"<leader>rf",
			":w<CR>:below split | term py %<CR>i",
			{ noremap = true, silent = true, buffer = true }
		)
	end,
})

-- Disable statusline for toggleterm
cmd([[
    augroup ToggleTermStatusline
        autocmd!
        autocmd TermOpen * setlocal statusline=Terminal
    augroup END
]])
