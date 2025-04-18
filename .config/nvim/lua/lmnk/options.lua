vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.mouse = 'a'
vim.wo.signcolumn = 'yes'

-- indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.hlsearch = false

-- Preview substitutions live
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 10

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Save undo history
vim.opt.undofile = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true

-- for all floating windows -> adds double borders for many plugins :((
vim.o.winborder = 'rounded'

vim.diagnostic.config {
    severity_sort = true,
    virtual_text = true,
    underline = true,
    float = { header = false, focusable = true },
    signs = { -- dont like
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
    },
}
