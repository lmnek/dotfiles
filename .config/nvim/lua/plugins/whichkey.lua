return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "<leader>H",  group = "Harpoon" },
        { "<leader>H_", hidden = true },
        { "<leader>h",  group = "Git Hunks" },
        { "<leader>h_", hidden = true },
        { "<leader>m",  group = "Manipulate text" },
        { "<leader>m_", hidden = true },
        { "<leader>r",  group = "Rename" },
        { "<leader>r_", hidden = true },
        { "<leader>s",  group = "Search" },
        { "<leader>s_", hidden = true },
        { "<leader>t",  group = "Toggle" },
        { "<leader>t_", hidden = true },
        { "<leader>w",  group = "Workspace" },
        { "<leader>w_", hidden = true },

        -- TODO: move somewhere else + required/dependency?
        { "<leader>o",  group = "Open" },
        { "<leader>og", ":Git<CR>",               desc = "Git" },
        { "<leader>ol", ":Lazy<CR>",              desc = "Lazy" },
        { "<leader>om", ":Mason<CR>",             desc = "Mason" },
    }
}
