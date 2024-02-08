return {
    -- NOTE: not the uberzug lf
    "lmburns/lf.nvim",
    cmd = "Lf",
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
    keys = {
        { "<leader>l", "<cmd>Lf<cr>", desc = "NeoTree" },
    },
    lazy = false,
    config = function()
        vim.g.lf_netrw = 1
        require("lf").setup({
            winblend = 0,
            border = "rounded",
            default_file_manager = true,
            disable_netrw_warning = true
        })
    end
}

