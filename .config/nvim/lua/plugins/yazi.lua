return {
    "mikavilpas/yazi.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
        {
            "<leader>f",
            function()
                require("yazi").yazi()
            end,
            desc = "File manager",
        },
        {
            "<leader>F",
            function()
                require("yazi").yazi(nil, vim.fn.getcwd())
            end,
            desc = "File manager in home dir",
        },
    },
    opts = {
        open_for_directories = true,
        floating_window_scaling_factor = 0.9
    },
}
