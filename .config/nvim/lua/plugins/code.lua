return {
    {
        -- Code actions with DIFF!
        'aznhe21/actions-preview.nvim',
        event = "VeryLazy",
        config = function()
            local actions_preview = require("actions-preview")
            actions_preview.setup({
                telescope = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.8,
                        height = 0.9,
                        prompt_position = "top",
                        preview_cutoff = 20,
                        preview_height = function(_, _, max_lines)
                            return max_lines - 15
                        end,
                    },
                },
            })
            vim.keymap.set({ 'n', 'v' }, "<leader>c", actions_preview.code_actions, { desc = "Code Actions" })
        end
    },
    {
        -- TODO: replace with https://github.com/echasnovski/mini.splitjoin
        -- Combine multiple lines into single one (or split one line into multiple ones)
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = { use_default_keymaps = false },
        keys = { { '<leader>ts', function() require('treesj').toggle() end, desc = 'split/join block' } }
    },
}
