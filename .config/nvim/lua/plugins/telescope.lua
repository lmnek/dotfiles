
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        local wk = require("which-key")

        wk.register({
            f = {
                name = "+find",
                f = { builtin.find_files, "Find Files" },
                g = { builtin.live_grep, "Live Grep" },
                b = { builtin.buffers, "Buffers" },
                h = { builtin.help_tags, "Help Tags" },
                t = { ":TodoTelescope<CR>", "Todos" }
            }
        }, { prefix = "<leader>" })
        wk.register({["<C-f>"] = { builtin.git_files, "Git Files" }})
    end
}
