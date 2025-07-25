-- For moving between files in nvim:
-- 1. Telescope - fzf like picker
-- 2. Grapple - bookmarks like navigation
-- 3. Yazi - (tree) file manager
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            {
                -- Faster searching alg, written in C
                -- note: will be part of telescope in the future
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    border = false, -- telescope broken since v0.11 global borders
                    vimgrep_arguments = {
                        'rg',
                        '--color', 'never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--hidden',
                        '--follow',
                        "--glob=!.git/",
                    }
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                },
            })
            -- Load extensions
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("ui-select")

            local builtin = require('telescope.builtin')

            -- Keybinds
            vim.keymap.set('n', '<C-f>', builtin.git_files, { desc = 'Search Git Files' })

            vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Buffers' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'All Files' })
            vim.keymap.set('n', '<leader>s?', builtin.oldfiles, { desc = 'Recently opened files' })
            vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Marks' })

            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })

            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep live' })
            vim.keymap.set('n', '<leader>sG', builtin.grep_string, { desc = 'On current Word' })

            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })

            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume (last search)' })
            vim.keymap.set('n', '<leader>sS', builtin.builtin, { desc = 'Telescope modes' })
        end
    },
    {
        -- ~ more powerful Harpoon
        -- (arrow is also alternative + it has line tags)
        "cbochs/grapple.nvim",
        opts = {
            scope = "git_branch",
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>ra", "<cmd>Grapple toggle<cr>",          desc = "Toggle tag" },
            { "<leader>rr", "<cmd>Grapple toggle_tags<cr>",     desc = "Tags window" },

            -- Harpoon-like workflow
            { "<C-1>",      "<cmd>Grapple select index=1<cr>",  remap = true,               desc = "Select first tag" },
            { "<C-2>",      "<cmd>Grapple select index=2<cr>",  remap = true,               desc = "Select second tag" },
            { "<C-3>",      "<cmd>Grapple select index=3<cr>",  remap = true,               desc = "Select third tag" },
            { "<C-4>",      "<cmd>Grapple select index=4<cr>",  remap = true,               desc = "Select fourth tag" },
            { "<C-5>",      "<cmd>Grapple select index=5<cr>",  remap = true,               desc = "Select fifth tag" },
            { "<C-6>",      "<cmd>Grapple select index=6<cr>",  remap = true,               desc = "Select sixth tag" },
            { "<C-7>",      "<cmd>Grapple select index=7<cr>",  remap = true,               desc = "Select seventh tag" },

            { "<leader>rn", "<cmd>Grapple cycle_tags next<cr>", desc = "Go to next tag" },
            { "<leader>rp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Go to previous tag" },
        },
    },
    {
        -- Yazi ~ terminal file manager
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
    },
}
