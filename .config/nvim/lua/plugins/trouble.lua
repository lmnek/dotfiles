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
            "<leader>oD",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics"
        },
        {
            "<leader>od",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics",
        },
        -- Many other features ... + can redirect Telescope results to this
        -- testing...
        -- Good
        {
            "<leader>os",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Doc Symbols",
        },
        -- Good (need to be on symbol)
        {
            "<leader>ol",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP definitions / references / ... ",
        },
        -- idk what this does
        -- {
        --     "<leader>oL",
        --     "<cmd>Trouble loclist toggle<cr>",
        --     desc = "Location List (Trouble)",
        -- },
        -- did not find use yet
        -- {
        --     "<leader>of",
        --     "<cmd>Trouble qflist toggle<cr>",
        --     desc = "Quickfix List (Trouble)",
        -- },
    },
}
