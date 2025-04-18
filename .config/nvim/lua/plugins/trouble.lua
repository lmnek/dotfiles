-- Super pretty diagnostic/quickfix/telescope list
return {
    "folke/trouble.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        focus = true, -- focus on toggle
        warn_no_results = true,
        auto_close = true,
        indent_guides = false,
    },
    -- cmd: Trouble [mode] [action] [options]
    cmd = "Trouble",
    -- note: has many useful keybinds in the window (e.g. 's' to change severity filter)
    -- -> '?' for help
    keys = {
        {
            "<leader>qa",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics"
        },
        {
            "<leader>qq",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics",
        },
        -- Many other features ... + can redirect Telescope results to this
        -- testing...
        -- Good
        {
            "<leader>qs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Doc Symbols",
        },
        -- Good
        {
            "<leader>qd",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... ",
        },
        -- idk what this does
        {
            "<leader>ql",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        -- did not find use yet
        {
            "<leader>qf",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
