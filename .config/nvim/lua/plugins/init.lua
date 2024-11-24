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
        keys = {
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" },
        }
    },
    -- Autoformat
    {
        'stevearc/conform.nvim',
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { "black" },
                -- You can use a sub-list to tell conform to run *until* a formatter is found.
                javascript = { { "prettierd", "prettier" } },
            },
        },
    },
    -- CODE ACTIONS with diff
    {
        'aznhe21/actions-preview.nvim',
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
    -- VISUALS -------------------
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_a = {
                    { 'mode', fmt = function(str) return str:sub(1, 1) end } },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            }
        },
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },

    -- RANDOM -------------------
    -- TODO: f-ing haskell ....
    -- {
    --     'mrcjkb/haskell-tools.nvim',
    --     version = '^3', -- Recommended
    --     ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject', 'tidal' },
    -- },
    {
        'tidalcycles/vim-tidal',
        ft = "tidal",
        config = function()
            vim.g.tidal_ghci = "stack exec ghci --"
        end
    },

    -- TESTING --------------
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = "VeryLazy",
        config = function()
            require('treesj').setup({
                use_default_keymaps = false,
            })
            vim.keymap.set('n', '<leader>ms', require('treesj').toggle, { desc = 'split/join block' })
        end
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
