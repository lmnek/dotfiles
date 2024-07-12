return {
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                options = {
                    signcolumn = "no"
                }
            }
        },
        keys = {
            { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
        }
    },
    {
        "folke/twilight.nvim",
        opts = {},
        keys = {
            { "<leader>tt", "<cmd>Twilight<cr>", desc = "Twilight" },
        }
    },
}
