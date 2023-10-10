
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        -- require('telescope').setup {
        -- mappings + other settings for telescope...
        -- }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<C-f>', builtin.git_files, {})
    end
}
