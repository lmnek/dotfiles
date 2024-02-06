
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<C-f>', builtin.git_files, { desc = 'Search Git Files' })

        vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Buffers' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'All Files' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'On current Word' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep live' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume (last search)' })
        vim.keymap.set('n', '<leader>s?', builtin.oldfiles, { desc = 'Recently opened files' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Select' })
    end
}
