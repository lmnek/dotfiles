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
    -- for Lf and Lazygit commands
    {
        "akinsho/toggleterm.nvim",
        opts = {},
        config = function()
            function _G.lazygit_toggle()
                local Terminal = require("toggleterm.terminal").Terminal
                local lazygit = Terminal:new({
                    cmd = "lazygit",
                    hidden = true,
                    direction = "float",
                    float_opts = {
                        -- fullscreen
                        height = vim.fn.float2nr(vim.o.lines - 1),
                        width = vim.fn.float2nr(vim.o.columns),
                        border = "none",
                        winblend = 0
                    },
                })
                lazygit:toggle()
            end

            vim.keymap.set("n", "<leader>g", "<cmd>lua lazygit_toggle()<CR>",
                { desc = "lazyGit", noremap = true, silent = true })
        end
    },
    { -- Autoformat
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
    'VebbNix/lf-vim', -- syntax highlighting for lfrc
}
