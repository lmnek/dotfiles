-- LSP config and plugins
-- TODO: lspconfig not necessary after neovim v0.11
-- https://github.com/boltlessengineer/NativeVim

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        -- Useful status updates for LSP
        {
            'j-hui/fidget.nvim',
            opts = {}
        },
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
    config = function()
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(client, bufnr)
            -- attach breadcrumbs
            require('nvim-navic').attach(client, bufnr)

            -- helper function for DRY
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>mr', vim.lsp.buf.rename, 'Rename')

            -- FIXME: some key-mappings overridden by new defaults
            nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

            nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            nmap('<leader>sd', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
            nmap('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                'Workspace Symbols (everywhere)')

            -- nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            nmap('<leader>Wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>Wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>Wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })

            -- The following code creates a keymap to toggle inlay hints in your
            -- code, if the language server you are using supports them
            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
                nmap('<leader>th', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
                end, '[T]oggle Inlay [H]ints')

                -- Enable inlay hints by default
                vim.lsp.inlay_hint.enable(true)
            end
        end

        -- mason-lspconfig requires that these setup functions are called in this order
        -- before setting up the servers.
        require('mason').setup()
        require('mason-lspconfig').setup()

        local servers = {
            pyright = {},
            rust_analyzer = {
                -- FIXME: no clippy diagnostics
                check = {
                    command = "clippy",
                },
            },
            bashls = {},
            lua_ls = {},
            tinymist = { -- typst
                single_file_support = true,
                settings = {},
            },
            -- latex
            texlab = {},
            ltex = {},
            -- web
            -- emmet_ls = {}, -- html snippet expansion
            svelte = {},
            tailwindcss = {},
            -- tsserver = {},
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
    end
}
