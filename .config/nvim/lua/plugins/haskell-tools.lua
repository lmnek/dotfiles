return {
    {
        "mrcjkb/haskell-tools.nvim",
        version = "^4",
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        dependencies = {
            { "nvim-telescope/telescope.nvim", optional = true },
        },
        -- requires = { 'neovim/nvim-lspconfig' },
    },
    {
        'tidalcycles/vim-tidal',
        ft = "tidal",
        config = function()
            vim.g.tidal_ghci = "stack exec ghci --"
        end
    }
}
