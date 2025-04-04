return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "VeryLazy",
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                return 'make install_jsregexp'
            end)(),
        },

        ---- Sources for CMP
        --- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

        'saadparwaiz1/cmp_luasnip',
        -- `friendly-snippets` contains a variety of premade snippets.
        --  https://github.com/rafamadriz/friendly-snippets
        {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
        'hrsh7th/cmp-path', -- note: has async alternative, better for large repos
        -- for cmd
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-buffer',
        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        -- extend JSX filetypes
        require('luasnip').filetype_extend("javascriptreact", { "javascript" })
        require('luasnip').filetype_extend("typescriptreact", { "javascript" })
        require('luasnip').filetype_extend("typescript", { "javascript" })


        cmp.setup {
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert',
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },

                -- TAB suggestion cycling!!!
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                -- move to the right/left of each of the expansion locations
                -- (multiple locations in one snippets)
                ['<C-Tab>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-S-Tab>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),

                -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'buffer' },
                { name = "nvim_lsp_signature_help" },
            },
        }

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                { { name = 'nvim_lsp_document_symbol' } },
                { { name = 'buffer' } })
        })
        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })
    end
}
