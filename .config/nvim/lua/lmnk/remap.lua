vim.g.mapleader = " " 
vim.g.maplocalleader = " "

-- move blocks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- stay in the position with J
vim.keymap.set("n", "J", "mzJ`z")

-- cursor in the middle 
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste over and stay copied
-- vim.keymap.set("x", "<leader>p", "\"_dP")
-- delete to void register...

-- system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<Enter>", "o<ESC>")
-- todo: add O; mark to stay in place?
-- vim.keymap.set("n", "<C-Enter>", "O<ESC>")

-- quickfix list for LSP


