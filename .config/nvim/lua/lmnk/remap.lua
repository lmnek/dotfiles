vim.g.mapleader = " " 
vim.g.maplocalleader = ","

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

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to Cliboard" })
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "Paste Clipboard"})

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "gl", "<nop>")
vim.keymap.set("n", "gh", "<nop>")

vim.keymap.set("n", "<Enter>", "o<ESC>")
-- TODO: add O; mark to stay in place?
-- vim.keymap.set("n", "<C-Enter>", "O<ESC>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.api.nvim_create_user_command('Lf', 'term lf', {})
