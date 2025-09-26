-- Super pretty diagnostic/quickfix/telescope list
-- TODO: position nicely with edgy.nvim (+ neotree, undolist)
return {
    "folke/trouble.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        focus = true, -- focus on toggle
        warn_no_results = true,
        auto_close = false,
        indent_guides = true,
        preview = { border = "" },
        title = false,
        modes = {
            diagnostics = {
                auto_close = true,
            },
            symbols = {
                title = false,
                groups = {},
            },
            todo = {
                auto_close = true,
                groups = {},
                format = "{todo_icon} {text} {filename}",
                sort = { "tag", "filename", "pos", "message" },
                filter = {
                    ['not'] = { tag = "NOTE" },
                },
            },
            lsp = {
                title = false,
                groups = {},
            },
            -- concrete items for LSP mode -> remove item.client and pos
            lsp_base = { format = "{text:ts}" },
            lsp_incoming_calls = { format = "{text:ts}" },
            lsp_outgoing_calls = { format = "{text:ts}" },
        },
        icons = {
            indent = { ws = " ", }, -- saving width space
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
