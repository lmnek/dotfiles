return { -- Adds git related signs to the gutter, hunks, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    opts = {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end, { desc = 'Next hunk' })

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end, { desc = 'Prev hunk' })

            -- Actions
            map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
            map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
            map('v', '<leader>ghs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = 'Stage hunk' })
            map('v', '<leader>ghr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = 'Reset hunk' })
            map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
            map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
            map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
            map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
            map('n', '<leader>ghb', function() gitsigns.blame_line { full = true } end, { desc = 'Blame line' })
            map('n', '<leader>ghB', gitsigns.toggle_current_line_blame, { desc = 'Toggle git Blame' })
            map('n', '<leader>ghd', gitsigns.diffthis, { desc = 'Diff' })
            map('n', '<leader>ghD', function() gitsigns.diffthis('~') end, { desc = 'Diff ~' })
            map('n', '<leader>ght', gitsigns.toggle_deleted, { desc = 'Toggle git Deleted' })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
}
