return {
    {
        -- Faster searching alg, written in C
        -- NOTE: will be part of telescope in the future
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            })

            require('telescope').load_extension('fzf')
            require("telescope").load_extension("ui-select")

            local builtin = require('telescope.builtin')

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
}
