-- Plugins with short setups
return {
    {
        'mbbill/undotree',
        keys = { { '<leader>ou', vim.cmd.UndotreeToggle, desc = "Undo tree" } }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = 'VimEnter',
        opts = { signs = false },
        -- TODO: add trouble
        keys = { { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" } }
    },
}
