-- LSP config and plugins
-- note: lspconfig not necessary after neovim v0.11 (but still easier)
-- https://github.com/boltlessengineer/NativeVim

local set_lsp_keybinds = function(client, bufnr)
    -- helper function for DRY
    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    map('<leader>tr', vim.lsp.buf.rename, 'Rename')

    ---- Word under cursor

    -- Find references for the word under your cursor.
    map('grr', require('telescope.builtin').lsp_references, 'Goto References')

    -- Jump to the definition of the word under your cursor.
    --  To jump back, press <C-t>.
    map('grd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gri', require('telescope.builtin').lsp_implementations, 'Goto Implementation')

    -- This is not Goto Definition, this is Goto Declaration.
    -- For example, in C this would take you to the header.
    map('grD', vim.lsp.buf.declaration, 'Goto Declaration')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('grt', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')



    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('<leader>sd', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')

    -- Fuzzy find all the symbols in your current workspace.
    -- Similar to document symbols, except searches over your entire project.
    map('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')


    map('<leader>Wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    map('<leader>Wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    map('<leader>Wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')


    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
        map('<leader>Th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
        end, '[T]oggle Inlay [H]ints')

        -- Enable inlay hints by default
        vim.lsp.inlay_hint.enable(true)
    end
end

local setup_mason = function(capabilities)
    -- configuration for individual servers
    local servers = {
        rust_analyzer = {
            check = {
                command = "clippy", -- fixme: no clippy diagnostics
            },
        },
        tinymist = { -- typst
            single_file_support = true,
            settings = {},
        },
        html = { filetypes = { 'html', 'svelte' } },
    }

    local ensure_installed = vim.tbl_keys(servers or {})

    -- add servers without configuration
    vim.list_extend(ensure_installed, {
        'ts_ls', 'prettier', 'svelte', 'tailwindcss',  -- 'emmet_ls', -- web
        'texlab', 'latexindent',                       -- latex
        'pyright', 'isort', 'flake8', 'black', 'ruff', -- python
        'clangd', 'lua_ls', 'bashls'                   -- ... others
    })

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                -- This handles overriding only values explicitly passed
                -- by the server configuration above. Useful when disabling
                -- certain features of an LSP (for example, turning off formatting for ts_ls)
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end,
        },
    }
end

return {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        -- Mason must be loaded before its dependents
        { 'williamboman/mason.nvim', opts = {} },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',


        { 'j-hui/fidget.nvim',       opts = {} }, -- Useful status updates
        'saghen/blink.cmp',                       -- completions

        {
            -- configures Lua LSP for Neovim config, runtime and plugins
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                },
            },
        },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        --  -> every time a new file is opened that is associated with
        --  an lsp, this function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('mine-lsp-attach', { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local buf = event.buf

                set_lsp_keybinds(client, buf)

                require('nvim-navic').attach(client, buf) -- attach breadcrumbs
            end
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        setup_mason(capabilities)
    end,
    keys = {
        { "<leader>oM", "<cmd>Mason<CR>",   desc = "Mason" },
        { "<leader>oS", "<cmd>LspInfo<CR>", desc = "Lsp Info" },
    }
}
