return {
    "folke/which-key.nvim",
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.setup({
            preset = "helix",
            sort = { "group", "local", "order", "alphanum", "mod" },
            triggers = {
                -- disable default s, because of mini-surround
                -- https://github.com/folke/which-key.nvim/issues/672
                { "<auto>", mode = "nixsotc" },
                { "s",      mode = { "n", "v" } },
            }
        })

        -- TODO: add icons to groups that doesnt have them
        -- eg: icon = { icon = "", color = "orange" }
        wk.add({
            { "<leader>s",  group = "+Search (Telescope)" },
            { "<leader>t",  group = "+Text / Treesitter" },
            { "<leader>o",  group = "+Open" },
            { "<leader>g",  group = "+Git" },
            { "<leader>gh", group = "+Hunks" },
            { "<leader>n",  group = "+Notifications" },
            { "<leader>q",  group = "+Trouble" },
            { "<leader>r",  group = "+gRapple" },
            { "<leader>T",  group = "+Toggle" },
            { "<leader>W",  group = "+Workspaces" },
            { "<leader>a",  group = "+AI" },

            { "<leader>oL", "<cmd>Lazy<CR>",              desc = "Lazy" },
        })
    end,
}
