return {
    {
        "Mofiqul/dracula.nvim",
        name = 'dracula',
        lazy = false,
        priority = 1000,
        config = function()
            require('dracula').setup({
                show_end_of_buffer = false,
                italic_comment = true,
                transparent_bg = false,
                colors = {
                    -- ITerm dracula version = darker bg
                    bg = '#1e1f29'
                },
                overrides = {}
            })
            vim.cmd.colorscheme 'dracula'
        end,
    },
    {
        -- Use it only as floating CMD
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", },
        opts = {
            cmdline = {
                enabled = true,         -- enables the Noice cmdline UI
                view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            },
            messages = {
                enabled = true,
                -- send info to right bottom corner
                view = "mini",
                -- snacks.notify will take care of it (I hope)
                view_warn = nil,
                view_error = nil
            },
            -- mini = { focusable = true },
            -- Disable all other features
            popupmenu = { enabled = false },
            lsp = {
                progress = { enabled = false },
                hover = { enabled = false },
                signature = { enabled = false },
            }
        }
    },
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
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                options = {
                    signcolumn = "no"
                }
            }
        },
        keys = {
            { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
        }
    },
    -- { 'petertriho/nvim-scrollbar', opts = {} },
}
