return {
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
}
