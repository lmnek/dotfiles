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
        event = 'VimEnter',
        opts = {
            signs = false
        },
        keys = {
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todos" },
        }
    },
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },
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
            }
        },
    },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
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
    {
        -- color theme for plantuml
        'javiorfo/nvim-nyctophilia',
        lazy = true,
        ft = 'plantuml',
        config = function()
            -- Available themes: nox, umbra, nebula and tenebra
            vim.cmd [[colorscheme nox]]
        end
    },
    {
        'javiorfo/nvim-soil',
        dependencies = { 'javiorfo/nvim-nyctophilia' },
        lazy = true,
        ft = "plantuml",
        opts = {},
        keys = {
            { ',s', '<cmd>Soil<CR>', { desc = { 'Soil PlantUML file' } } }
        }
    },
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
