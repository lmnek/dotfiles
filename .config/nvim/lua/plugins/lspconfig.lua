-- LSP config and plugins

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        -- NOTE: could not get transparent background
        -- Useful status updates for LSP
        -- {
        --     'j-hui/fidget.nvim',
        --     opts = {
        --         window = {
        --             blend = 0, -- note: not winblend!
        --             relative = "editor"
        --         }
        --     },
        --     tag = "legacy"
        -- },
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
    config = function()
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            -- helper function for DRY
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', function()
                vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
            end, '[C]ode [A]ction')

            nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        -- mason-lspconfig requires that these setup functions are called in this order
        -- before setting up the servers.
        require('mason').setup()
        require('mason-lspconfig').setup()

        local servers = {
            pyright = {},
            rust_analyzer = {},
            bashls = {},
            lua_ls = {},
            -- latex
            texlab = {},
            vale_ls = {},
            -- web
            -- emmet_ls = {}, -- html snippet expansion
            svelte = {},
            tailwindcss = {},
            tsserver = {},
            html = { filetypes = { 'html', 'svelte' } },
        }

        -- Setup neovim lua configuration
        require('neodev').setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })
    end
}
