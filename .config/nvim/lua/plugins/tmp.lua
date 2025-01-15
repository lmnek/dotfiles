-- Plugins currently being tested / worked on
return {
    {
        "tris203/precognition.nvim",
        opts = {
            startVisible = false,
        },
        keys = {
            { '<leader>tp', function() require("precognition").toggle() end, desc = 'Precognition hints' }
        }
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
        build = function() require("typst-preview").update() end,
        opts = {
            dependencies_bin = { tinymist = "tinymist" }
        },
        keys = {
            { ',p', "<cmd>TypstPreview<CR>",       desc = 'Typst Preview' },
            { ',t', "<cmd>TypstPreviewToggle<CR>", desc = 'Typst Preview Toggle' },
            { ',u', "<cmd>TypstPreviewUpdate<CR>", desc = 'Typst Preview Update' },
        }
    },
    -- TODO: fix inlay hints
    -- Simple plugin to just enable inlay hints for each LSP server
    -- {
    --     "MysticalDevil/inlay-hints.nvim",
    --     event = "LspAttach",
    --     dependencies = { "neovim/nvim-lspconfig" },
    --     config = function()
    --         require("inlay-hints").setup()
    --     end
    -- },
    -- TODO: zellij nav
    -- {
    --     "https://git.sr.ht/~swaits/zellij-nav.nvim",
    --     lazy = true,
    --     event = "VeryLazy",
    --     keys = {
    --         { "<M-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left" } },
    --         { "<M-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down" } },
    --         { "<M-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up" } },
    --         { "<M-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    --     },
    --     opts = {},
    -- }
    -- NOTE: probably will not use...
    -- {
    -- 'Bekaboo/dropbar.nvim',
    -- dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- event = "VeryLazy",
    -- -- todo: open fzf mode
    -- keys = {
    --     { '<leader>b', function() require('dropbar.api').pick() end,                desc = 'Bar symbol navigation' },
    --     { '[;',        function() require('dropbar.api').goto_context_start() end,  desc = 'Go to start of current context' },
    --     { '];',        function() require('dropbar.api').select_next_context() end, desc = 'Select next context' },
    --     -- fixme: toggle bar
    --     {
    --         '<leader>tb',
    --         function()
    --             require('dropbar.api').enable = not require('dropbar.api').opts.enable
    --         end,
    --         desc = 'Toggle dropbar (winbar)'
    --     },
    -- }
    --}
}
