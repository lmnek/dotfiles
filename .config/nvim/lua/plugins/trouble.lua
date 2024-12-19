-- Super pretty diagnostic/quickfix/telescope list
return {
    "folke/trouble.nvim",
    opts = {
        focus = true, -- focus on toggle
        warn_no_results = false
    },
    -- cmd: Trouble [mode] [action] [options]
    cmd = "Trouble",
    -- NOTE: has many useful keybinds in the window (e.g. 's' to change severity filter)
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
        -- {
        --     "<leader>Ts",
        --     "<cmd>Trouble symbols toggle focus=false<cr>",
        --     desc = "Symbols (Trouble)",
        -- },
        -- {
        --     "<leader>Td",
        --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        --     desc = "LSP Definitions / references / ... (Trouble)",
        -- },
        -- {
        --     "<leader>Tl",
        --     "<cmd>Trouble loclist toggle<cr>",
        --     desc = "Location List (Trouble)",
        -- },
        -- {
        --     "<leader>Tq",
        --     "<cmd>Trouble qflist toggle<cr>",
        --     desc = "Quickfix List (Trouble)",
        -- },
    },
}
