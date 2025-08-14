return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            {
                "github/copilot.vim",
                config = function()
                    vim.api.nvim_set_keymap('i', '<C-l>', 'copilot#Accept()',
                        { expr = true, silent = true, noremap = false })
                end
            }, -- or zbirenbaum/copilot.lua
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
            { "<leader>a",  "",                            desc = "+Ai",           mode = { "n", "v" } },
            { "<leader>aa", "<cmd>CopilotChatToggle<cr>",  desc = "Toggle chat",   mode = { "n", "v" } },
            { "<leader>ar", "<cmd>CopilotChatReset<cr>",   desc = "Reset chat",    mode = { "n", "v" } },
            { "<leader>aS", "<cmd>CopilotChatStop<cr>",    desc = "Stop output",   mode = { "n", "v" } },
            { "<leader>ap", "<cmd>CopilotChatPrompts<cr>", desc = "Select prompt", mode = { "n", "v" } },
            { "<leader>am", "<cmd>CopilotChatModels<cr>",  desc = "Select model",  mode = { "n", "v" } },
            { "<leader>ag", "<cmd>CopilotChatAgents<cr>",  desc = "Select agent",  mode = { "n", "v" } },
        },
    }, }
