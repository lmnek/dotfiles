return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },     -- if you use the mini.nvim suite
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function()
        local set_heading_color = function(heading_num, col_link)
            vim.api.nvim_set_hl(0, "@markup.heading." .. heading_num .. ".markdown", { link = col_link })
            vim.api.nvim_set_hl(0, "RenderMarkdownH" .. heading_num .. "Bg", { link = "Visual" })     -- transparent bg
        end
        set_heading_color(1, "rainbowcol2")
        set_heading_color(2, "rainbowcol3")
        set_heading_color(3, "rainbowcol4")
        set_heading_color(4, "rainbowcol5")
        set_heading_color(5, "rainbowcol6")
        set_heading_color(6, "rainbowcol1")     -- white

        require("render-markdown").setup({
            sign = {
                enabled = false,
            },
            heading = {
                position = 'inline',
            },
            overrides = {
                buflisted = {},
                buftype = {
                    nofile = {     -- e.g.: hover docs
                        code = {
                            style = 'normal',
                            disable_background = true,
                        },
                    },
                },
                filetype = {},
            },
        })
    end
}
