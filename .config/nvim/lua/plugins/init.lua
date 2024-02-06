-- Plugins with short setups
return {
    -- ESSENTIALS -------------------
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo tree" })
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('todo-comments').setup({})
            vim.keymap.set('n', '<leader>st', ":TodoTelescope<CR>", { desc = 'Todos' })
        end
    },
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- VISUALS -------------------
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },

    -- NICE-TO-HAVE -------------------
    'tpope/vim-fugitive',

    -- RANDOM -------------------
    'tidalcycles/vim-tidal',
}
