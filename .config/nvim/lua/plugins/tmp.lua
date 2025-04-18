-- Plugins currently being tested / worked on
return {
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        cmd = "CopilotChat",
        opts = function()
            local user = vim.env.USER or "User"
            user = user:sub(1, 1):upper() .. user:sub(2)
            return {
                auto_insert_mode = true,
                question_header = "  " .. user .. " ",
                answer_header = "  Copilot ",
                window = {
                    width = 0.4,
                },
            }
        end,
        keys = {
            { "<leader>a",  "",                            desc = "+ai",           mode = { "n", "v" } },
            { "<leader>aa", "<cmd>CopilotChatToggle<cr>",  desc = "Toggle chat",   mode = { "n", "v" } },
            { "<leader>ar", "<cmd>CopilotChatReset<cr>",   desc = "Reset chat",    mode = { "n", "v" } },
            { "<leader>aS", "<cmd>CopilotChatStop<cr>",    desc = "Stop output",   mode = { "n", "v" } },
            { "<leader>ap", "<cmd>CopilotChatPrompts<cr>", desc = "Select prompt", mode = { "n", "v" } },
            { "<leader>am", "<cmd>CopilotChatModels<cr>",  desc = "Select model",  mode = { "n", "v" } },
            { "<leader>ag", "<cmd>CopilotChatAgents<cr>",  desc = "Select agent",  mode = { "n", "v" } },
        },
    },
    { 'subnut/nvim-ghost.nvim' }, -- connect to browser input
    -- TODO: zellij nav
    -- {
    --     "https://git.sr.ht/~swaits/zellij-nav.nvim",
    --     lazy = true,
    --     event = "VeryLazy",
    --     keys = {
    --         { "<M-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left" } },
    --         { "<M-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
    --         { "<M-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
    --         { "<M-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    --     },
    --     opts = {},
    -- }

    -- note: probably will not use (already have navic in lualine)... but it is so niceee
    -- {
    -- 'Bekaboo/dropbar.nvim',
    -- dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- event = "VeryLazy",
    -- -- todo: open fzf mode
    -- keys = {
    --     { '<leader>b', function() require('dropbar.api').pick() end,                desc = 'Bar symbol navigation' },
    --     { '[;',        function() require('dropbar.api').goto_context_start() end,  desc = 'Go to start of current context' },
    --     { '];',        function() require('dropbar.api').select_next_context() end, desc = 'Select next context' },
    --     -- fixme: toggle bar
    --     {
    --         '<leader>tb',
    --         function()
    --             require('dropbar.api').enable = not require('dropbar.api').opts.enable
    --         end,
    --         desc = 'Toggle dropbar (winbar)'
    --     },
    -- }
    --}
}
