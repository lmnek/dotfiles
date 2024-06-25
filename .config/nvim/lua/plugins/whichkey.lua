return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        -- document existing key chains
        require('which-key').register {
            ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
            ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
            ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
            ['<leader>t'] = { name = 'Toggle', _ = 'which_key_ignore' },
            ['<leader>h'] = { name = 'Harpoon', _ = 'which_key_ignore' },
            -- ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },

            -- TODO: move somewhere else + required?
            ['<leader>o'] = {
                name = "+Open",
                l = { ":Lazy<CR>", "Lazy" },
                g = { ":Git<CR>", "Git" },
                m = { ":Mason<CR>", "Mason" }
            }
        }
    end
}
