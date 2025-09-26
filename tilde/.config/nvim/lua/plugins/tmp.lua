-- Plugins currently being tested / worked on
return {
    -- colorful matching parens
    { 'HiPhish/rainbow-delimiters.nvim' },

    -- display color codes in their bg (+ can add blink.cmp integration later)
    { 'brenoprata10/nvim-highlight-colors',  opts = {} },

    -- statusline numbers limited for typing numbers only with left hand for j / k jumps
    { 'mluders/comfy-line-numbers.nvim',     opts = {} },

    { "chentoast/marks.nvim",                event = "VeryLazy", opts = {}, },

    -- smart incremental select: "." in visual mode
    { 'RRethy/nvim-treesitter-textsubjects', opts = {},          config = function() end },

    -- automatic markdown bullet lists + toggle checkbox via "<leader>x"
    { 'bullets-vim/bullets.vim',             opts = {},          config = function() end },

    -- Make ] or [ motions repeatable with ; and ,
    {
        'mawkler/demicolon.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        opts = {},
    },

    -- NOTE: realized I just like to look at the dir structure.. especially in unknown new projects
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false, -- neo-tree will lazily load itself
        opts = {
            filesystem = {
                hijack_netrw_behavior = "disabled",
            }
        },
        keys = {
            { "<leader>of", "<cmd>Neotree filesystem reveal right<cr>", desc = "Neotree", mode = { "n", "v" } },
        }
    },
}
