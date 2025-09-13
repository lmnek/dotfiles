local minimalTreeModeOpts = {
    title = false,
    groups = {},
}

-- Super pretty diagnostic/quickfix/telescope list
-- TODO:
--  - position nicely with edgy.nvim (+ neotree, undolist)
--  - TODO list
return {
    "folke/trouble.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        focus = true, -- focus on toggle
        warn_no_results = true,
        auto_close = true,
        indent_guides = false,
        preview = { border = "" },
        title = false,
        modes = {
            symbols = minimalTreeModeOpts,
            lsp = minimalTreeModeOpts,
            todo = {
                groups = {},
                format = "{todo_icon} {text} {filename} {pos}",
                sort = { "tag", "filename", "pos", "message" },
                filter = {
                    ['not'] = { tag = "NOTE" },
                },
            }
        },
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
            "<cmd>Trouble diagnostics toggle filter.buf=0 groups=false<cr>",
            desc = "Buffer Diagnostics",
        },
        {
            "<leader>os",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Buffer Symbols",
        },
        {
            "<leader>ol", -- (need to be on symbol)
            "<cmd>Trouble lsp toggle<cr>",
            desc = "Symbol defs/refs/... ",
        },
        {
            "<leader>ot",
            "<cmd>Trouble todo toggle<cr>",
            desc = "TODO comments",
        },
        {
            "[q",
            function()
                if require("trouble").is_open() then
                    require("trouble").prev({ skip_groups = true, jump = true })
                end
            end,
            desc = "Previous Trouble Item",
        },
        {
            "]q",
            function()
                if require("trouble").is_open() then
                    require("trouble").next({ skip_groups = true, jump = true })
                end
            end,
            desc = "Next Trouble Item",
        },
    },
}
