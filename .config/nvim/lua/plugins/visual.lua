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
    }
}
