-- ~ more powerful Harpoon
-- (arrow is also alternative + it has line tags)
return {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        { "<leader>ra", "<cmd>Grapple toggle<cr>",          desc = "Toggle tag" },
        { "<leader>rr", "<cmd>Grapple toggle_tags<cr>",     desc = "Tags window" },

        -- Harpoon-like workflow
        { "<c-h>",      "<cmd>Grapple select index=1<cr>",  desc = "Select first tag" },
        { "<c-j>",      "<cmd>Grapple select index=2<cr>",  desc = "Select second tag" },
        { "<c-k>",      "<cmd>Grapple select index=3<cr>",  desc = "Select third tag" },
        { "<c-l>",      "<cmd>Grapple select index=4<cr>",  desc = "Select fourth tag" },

        { "<leader>rn", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
        { "<leader>rp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
    },
}
