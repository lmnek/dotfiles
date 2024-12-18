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
            { "<leader>oL", ":LspInfo<CR>",            desc = "Lsp Info" },
        })
    end,

}
