local opts = { noremap = true, silent = true }

local opts_no_silent = { noremap = true }

local keymap = vim.keymap.set

-- Control S to save
keymap("n", "<C-s>", ":w<CR>", opts)

-- Move with Control in insert mode
-- keymap("i", "<C-h>", "<Left>", opts)
-- keymap("i", "<C-l>", "<Right>", opts)
-- keymap("i", "<C-k>", "<Up>", opts)
-- keymap("i", "<C-j>", "<Down>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down with auto indentation
keymap("v", "<S-J>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-K>", ":m '<-2<CR>gv=gv", opts)

-- Yank to clipboard
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>y", '"+y', opts)

-- Pasting will not yank
keymap("v", "p", '"_dp', opts)

-- X will not yank
keymap("n", "x", '"_x', opts)

-- Delete without yank
keymap({ "n", "v" }, "<leader>d", [["_d]])

-- Replace the word where cursor is
keymap("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts_no_silent)

-- Keep cursor on center (from Prime)
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Change window
keymap("n", "<leader><Tab>", "<C-w>w", opts)

-- New Windows Terminal window in the same dir
keymap("n", "<leader>pw", ":!wt -d .<CR><CR>", opts)
