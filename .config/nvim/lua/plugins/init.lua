-- Plugins with short setups
return {
    -- ESSENTIALS -------------------
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
    -- TESTING --------------
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = { use_default_keymaps = false },
        keys = { { '<leader>ms', function() require('treesj').toggle() end, desc = 'split/join block' } }
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        opts = {},
    }
    -- TODO: fix inlay hints
    -- Simple plugin to just enable inlay hints for each LSP server
    -- {
    --     "MysticalDevil/inlay-hints.nvim",
    --     event = "LspAttach",
    --     dependencies = { "neovim/nvim-lspconfig" },
    --     config = function()
    --         require("inlay-hints").setup()
    --     end
    -- },
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
}
