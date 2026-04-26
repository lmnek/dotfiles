-- Treesitter + Text objects
-- update to nvim 0.12 inspired by: https://mhpark.me/posts/update-treesitter-main/
return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
        init = function()
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    -- You can choose the select mode (default is charwise 'v')

                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
                move = {
                    -- whether to set jumps in the jumplist
                    set_jumps = true,
                },
            }

            -- Selects
            local select = require "nvim-treesitter-textobjects.select"
            -- parameter
            vim.keymap.set({ "x", "o" }, "aa", function()
                select.select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ia", function()
                select.select_textobject("@parameter.inner", "textobjects")
            end)
            -- function
            vim.keymap.set({ "x", "o" }, "am", function()
                select.select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "im", function()
                select.select_textobject("@function.inner", "textobjects")
            end)
            -- class
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@class.inner", "textobjects")
            end)
            -- comment (inner much less supported, fall back to outer)
            vim.keymap.set({ "x", "o" }, "aC", function()
                select.select_textobject("@comment.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "iC", function()
                select.select_textobject("@comment.outer", "textobjects")
            end)
            -- local scope (extra, not in commented config; pairs with ]s/[s)
            vim.keymap.set({ "x", "o" }, "as", function()
                select.select_textobject("@local.scope", "locals")
            end)

            -- Swaps
            local swap = require("nvim-treesitter-textobjects.swap")
            vim.keymap.set("n", "<leader>ta", function()
                swap.swap_next "@parameter.inner"
            end)
            vim.keymap.set("n", "<leader>tA", function()
                swap.swap_previous "@parameter.inner"
            end)


            local move = require("nvim-treesitter-textobjects.move")
            -- Functions
            vim.keymap.set({ "n", "x", "o" }, "]m", function()
                move.goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                move.goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end)

            -- Classes (shadows vim's diff-mode ]c/[c — not used here)
            vim.keymap.set({ "n", "x", "o" }, "]c", function()
                move.goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]C", function()
                move.goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[c", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[C", function()
                move.goto_previous_end("@class.outer", "textobjects")
            end)

            -- Conditionals (goto_next/goto_previous = nearer of start/end)
            -- Previous config bound these to ]C/[C, which collided with class
            -- end above. Moved to ]i/[i (i = "if"); shadows vim's rarely-used
            -- "jump to include".
            vim.keymap.set({ "n", "x", "o" }, "]i", function()
                move.goto_next("@conditional.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[i", function()
                move.goto_previous("@conditional.outer", "textobjects")
            end)

            -- Extras (not in commented config, kept for usefulness)
            -- Loop / local scope / fold — pass a list to group multiple queries
            vim.keymap.set({ "n", "x", "o" }, "]o", function()
                move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[o", function()
                move.goto_previous_start({ "@loop.inner", "@loop.outer" }, "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]s", function()
                move.goto_next_start("@local.scope", "locals")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[s", function()
                move.goto_previous_start("@local.scope", "locals")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]z", function()
                move.goto_next_start("@fold", "folds")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[z", function()
                move.goto_previous_start("@fold", "folds")
            end)

            local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            -- ABSOLUTELY BEST FEATURE EVER 😻😻😻 - so fast !!!
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)


            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        build = ':TSUpdate',
        config = function()
            local ts = require 'nvim-treesitter'
            local parsers = {
                "bash",
                "comment",
                "css",
                "diff",
                "dockerfile",
                "git_config",
                "gitcommit",
                "gitignore",
                "go",
                "html",
                "http",
                "java",
                "javascript",
                "jsdoc",
                "json",
                "json5",
                "haskell",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "rst",
                "rust",
                "scss",
                "ssh_config",
                "sql",
                "terraform",
                "typst",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            }

            for _, parser in ipairs(parsers) do
                ts.install(parser)
            end

            -- Not every tree-sitter parser is the same as the file type detected
            -- So the patterns need to be registered more cleverly
            local patterns = {}
            for _, parser in ipairs(parsers) do
                local parser_patterns = vim.treesitter.language.get_filetypes(parser)
                for _, pp in pairs(parser_patterns) do
                    table.insert(patterns, pp)
                end
            end

            -- vim.treesitter.language.register("groovy", "Jenkinsfile")
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'

            vim.api.nvim_create_autocmd('FileType', {
                pattern = patterns,
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end
    }
}
