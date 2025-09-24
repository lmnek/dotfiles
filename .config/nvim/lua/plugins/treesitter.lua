-- Treesitter + Text objects
return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
        vim.defer_fn(function()
            require('nvim-treesitter.configs').setup {
                -- Add languages to be installed here that you want installed for treesitter
                ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'html', 'css', 'json', 'haskell' },

                auto_install = true,
                -- Install languages synchronously (only applied to `ensure_installed`)
                sync_install = false,
                -- List of parsers to ignore installing
                ignore_install = {},
                -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
                modules = {},
                highlight = { enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        -- FIXME: dont know what with these
                        -- scope_incremental = '<c-S->',
                        -- node_decremental = '<c-S-space>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            -- parameter
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            -- function
                            ['am'] = '@function.outer',
                            ['im'] = '@function.inner',
                            -- class
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                            -- comment
                            ['aC'] = '@comment.outer',
                            ['iC'] = '@comment.outer', -- inner much less supported..
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        -- Functions + Classes
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']c'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']C'] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[c'] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[C'] = '@class.outer',
                        },
                        -- Conditions
                        goto_next = {
                            ["]C"] = "@conditional.outer",
                        },
                        goto_previous = {
                            ["[C"] = "@conditional.outer",
                        }
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>ta'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>tA'] = '@parameter.inner',
                        },
                    },
                },
            }
        end, 0)
    end
}
