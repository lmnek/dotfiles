return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>H",  group = "+Harpoon" },
            { "<leader>h",  group = "+Git Hunks" },
            { "<leader>m",  group = "+Manipulate text" },
            { "<leader>r",  group = "+Rename" },
            { "<leader>s",  group = "+Search" },
            { "<leader>t",  group = "+Toggle" },
            -- { "<leader>w",  group = "+Workspace" },
            -- TODO: move somewhere else + required/dependency?
            { "<leader>o",  group = "+Open" },
            { "<leader>og", ":Git<CR>",                desc = "Git" },
            { "<leader>ol", ":Lazy<CR>",               desc = "Lazy" },
            { "<leader>om", ":Mason<CR>",              desc = "Mason" },
        })
    end,
}
