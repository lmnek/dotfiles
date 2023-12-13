return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        -- your configuration comes here
    },
    config = function()
        local wk = require("which-key")
        wk.register({
            o = {
                name = "+open",
                l = { ":Lazy<CR>", "Lazy" },
                g = { ":Git<CR>", "Git" },
                m = { ":Mason<CR>", "Mason" },
            },
            p = {
                name = "+project",
                v = { vim.cmd.Ex, "Project View" }
            }
        }, { prefix="<leader>" })

    end
}
