local opts = { noremap = true, silent = true }

local opts_silence = { silent = true }

local opts_no_silent = { noremap = true }

local keymap = vim.keymap.set

-- Set leader key to Space
vim.g.mapleader = " "

-- Disable Space in normal and visual mode
keymap({ "n", "v" }, "<Space>", "<Nop>", opts_silence)

-- Control S to save
keymap("n", "<C-s>", ":w<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down with auto indentation
keymap("v", "<S-J>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-K>", ":m '<-2<CR>gv=gv", opts)

-- Yank to clipboard
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" }, opts)
keymap("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" }, opts)

-- Pasting will not yank
keymap("v", "p", '"_dp', opts)

-- X will not yank
keymap("n", "x", '"_x', opts)

-- Delete without yank
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yank" })

-- Replace the word where cursor is
keymap("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename" }, opts_no_silent)

-- Keep cursor on center (from Prime)
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Change window
keymap("n", "<leader><Tab>", "<C-w>w", { desc = "Go to the next window" }, opts)

-- Splits
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })

-- Increment and decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap("n", "<C-f>", ":OpenWorkspace ~/", { desc = "Change directory" })

-- Yank entire function
keymap("n", "YY", "va{Vy}", opts, { desc = "Yank entire function" })
