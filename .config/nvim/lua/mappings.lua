local opts = { noremap = true, silent = true }

local opts_silence = { silent = true }

local keymap = vim.keymap.set

local cmd = vim.cmd

-- Set leader key to Space
vim.g.mapleader = " "

-- Make CTRL+C behave like ESC, useful in vertical editing
keymap("i", "<C-c>", "<ESC>")

-- Disable Space in normal and visual mode
keymap({ "n", "v" }, "<Space>", "<Nop>", opts_silence)

-- Control S to save
keymap({ "n", "i" }, "<C-s>", "<CMD>w<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down with auto indentation
keymap("v", "<S-J>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-K>", ":m '<-2<CR>gv=gv", opts)

-- Yank to clipboard
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Pasting will not yank
keymap("v", "p", '"_dp', opts)

-- X will not yank
keymap("n", "x", '"_x', opts)

-- Delete without yank
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yank" })

-- Replace the word where cursor is
keymap("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename word under cursor" })

-- Keep cursor on center (from Prime)
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Change window
keymap("n", "<leader><Tab>", "<C-w>w", { desc = "Go to the next window" })

-- Splits
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })

-- Increment and decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Yank entire function
keymap("n", "YY", "va{Vy}", { desc = "Yank entire function" })

local function add_to_portuguese_dict()
	cmd("set spelllang=pt")
	cmd("normal zg")
	cmd("silent mkspell! ~/.config/nvim/spell/pt.utf-8.add")
	cmd("set spelllang=en_us,pt")
end

local function remove_from_portuguese_dict()
	cmd("set spelllang=pt")
	cmd("normal zw")
	cmd("silent mkspell! ~/.config/nvim/spell/pt.utf-8.add")
	cmd("set spelllang=en_us,pt")
end

keymap("n", "<leader>zg", add_to_portuguese_dict, { desc = "Add word to Portuguese dictionary" })
keymap("n", "<leader>zw", remove_from_portuguese_dict, { desc = "Remove word from Portuguese dictionary" })

keymap("n", "<leader>pd", function()
	vim.fn.jobstart({ "previewpdf", vim.fn.expand("%") })
end, { desc = "Preview PDF" })

-- Go to previous buffer
keymap("n", "<C-a>", "<C-^>")

-- nvim wrapper for find-projects script
keymap("n", "<C-f>", function()
	os.execute("touch /tmp/find-projects")
	cmd("q!")
end, { desc = "Find projects" })
