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

    -- Make ] or [ motions repeatable with ; and ,
    {
        'mawkler/demicolon.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        opts = {},
    },
}
