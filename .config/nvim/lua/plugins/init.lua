-- Plugins with short setups
return {
    {
        'mbbill/undotree',
        keys = { { '<leader>u', vim.cmd.UndotreeToggle, desc = "Undo tree" } }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = 'VimEnter',
        opts = { signs = false },
        keys = { { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" } }
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = { use_default_keymaps = false },
        keys = { { '<leader>ms', function() require('treesj').toggle() end, desc = 'split/join block' } }
    },
}
