-- Autocompletion
return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
        -- Snippet Engine
        {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = (function()
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                -- `friendly-snippets` contains a variety of premade snippets.
                --    https://github.com/rafamadriz/friendly-snippets
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
            -- Sources for CMP: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
            opts = {},
        },
        'folke/lazydev.nvim',
    },
    opts = {
        keymap = {
            preset = 'enter',
            -- ['<Enter>'] = { 'select_and_accept' },
            ['<C-e>'] = { 'hide' },

            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback_to_mappings' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback_to_mappings' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },

        appearance = {
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
        },

        completion = {
            -- By default, press `<c-space>` to show the documentation.
            documentation = { auto_show = true, auto_show_delay_ms = 500, },

            -- will fuzzy match on the text before _and_ after the cursor
            keyword = { range = 'full' },

            ghost_text = { enabled = false },
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'lazydev' }, -- 'buffer' automatically included without lsp
            providers = {
                lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },

        snippets = { preset = 'luasnip' },

        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" }
}

-- Random leftovers from CMP:
-- -- extend JSX filetypes
-- require('luasnip').filetype_extend("javascriptreact", { "javascript" })
-- require('luasnip').filetype_extend("typescriptreact", { "javascript" })
-- require('luasnip').filetype_extend("typescript", { "javascript" })
