return {
    -- TODO: finish setup
    -- PR review prompt: https://github.com/olimorris/codecompanion.nvim/discussions/389
    -- inspo: https://github.com/olimorris/codecompanion.nvim/discussions/82
    --https://github.com/vanillacode314/stow-dotfiles/blob/main/dot-config/nvim/lua/plugins/codecompanion.lua
    {
        "olimorris/codecompanion.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
            -- is broken idk?
            -- {
            --     "echasnovski/mini.diff",
            --     config = function()
            --         local diff = require("mini.diff")
            --         diff.setup({
            --             -- Disabled by default
            --             source = diff.gen_source.none(),
            --         })
            --     end,
            -- },
        },
        init = function()
            -- Expand 'cc' into 'CodeCompanion' in the command line
            vim.cmd([[cab cc CodeCompanion]])
        end,
        config = function()
            local opts = {
                display = {
                    chat = {
                        window = {
                            -- layout = "buffer"
                            position = "right"
                        }
                    },
                    -- diff = {
                    --     enabled = true,
                    --     -- close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
                    --     layout = "vertical",
                    --     opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                    --     provider = "mini_diff", -- default|mini_diff
                    -- },
                }
            }
            require("codecompanion").setup(opts)
        end,
        cmd = { "CodeCompanion" },
        keys = {
            { "<leader>aa", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "AI actions" },
            { "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle AI buffer" },
            { "ga",         "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          desc = "Add to AI" }
            -- also keybinds starttin with "g" in the chat buffer -> info / change adapter /  clear chat / ...
        }
    },
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({})
    --     end,
    -- },
}
