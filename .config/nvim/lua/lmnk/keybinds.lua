vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- move blocks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines down" })

-- stay in the position with J
vim.keymap.set("n", "J", "mzJ`z")

-- cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to Cliboard" })
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "Paste Clipboard" })

-- Create newline above/bellow
vim.keymap.set("n", "<Enter>", "o<ESC>")
vim.keymap.set("n", "<S-Enter>", "O<ESC>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<leader>w', "<cmd>up<CR>", { desc = '::up' })
vim.keymap.set('n', '<leader>W', "<cmd>wa<CR>", { desc = '::wa' })

-- Splits navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { desc = ':q' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Floating diagnostic' })
-- vim.diagnostic.setloclist -> diagnostic list replaced with trouble

-- Toggle virtual lines and underlines
vim.keymap.set('n', '<leader>Tv', function()
    if vim.diagnostic.config().virtual_lines then
        vim.diagnostic.config({ virtual_lines = false })
    else
        vim.diagnostic.config({ virtual_lines = { current_line = true } })
    end
end, { desc = 'Virtual lines diagnostics' })

vim.keymap.set('n', '<leader>Tu', function()
    vim.diagnostic.config({ underline = not vim.diagnostic.config().underline })
end, { desc = 'Underline diagnostics' })


-- I dont like those / use replacements
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "gl", "<nop>")
vim.keymap.set("n", "gh", "<nop>")
