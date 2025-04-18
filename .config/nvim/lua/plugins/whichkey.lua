return {
    "folke/which-key.nvim",
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.setup({
            preset = "helix",
            sort = { "group", "local", "order", "alphanum", "mod" },
            -- disable default s, because of mini-surround
            -- https://github.com/folke/which-key.nvim/issues/672
            triggers = {
                { "<auto>", mode = "nixsotc" },
                { "s",      mode = { "n", "v" } },
            }
        })

        wk.add({
            { "<leader>h",  group = "+Git Hunks" },
            { "<leader>m",  group = "+Manipulate text" },
            { "<leader>s",  group = "+Search" },
            { "<leader>t",  group = "+Toggle" },
            { "<leader>g",  group = "+Git" },
            { "<leader>n",  group = "+Notifications" },
            { "<leader>q",  group = "+Trouble Diagnostics" },
            { "<leader>r",  group = "+gRapple" },
            { "<leader>W",  group = "+Workspace" },
            -- todo: move somewhere else + required/dependency?
            { "<leader>o",  group = "+Open" },
            { "<leader>ol", "<cmd>Lazy<CR>",               desc = "Lazy" },
            { "<leader>om", "<cmd>Mason<CR>",              desc = "Mason" },
            { "<leader>oL", "<cmd>LspInfo<CR>",            desc = "Lsp Info" },
        })
    end,

}
