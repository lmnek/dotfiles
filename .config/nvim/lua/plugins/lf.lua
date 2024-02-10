return {
    -- NOTE: not the uberzug lf
    "lmburns/lf.nvim",
    cmd = "Lf",
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
    keys = {
        { "<leader>l", "<cmd>Lf<cr>", desc = "lf" },
    },
    lazy = false,
    config = function()
        vim.g.lf_netrw = 1
        require("lf").setup({
            winblend = 0,
            default_file_manager = true,
            disable_netrw_warning = true,
            -- fullscreen
            height = vim.fn.float2nr(vim.o.lines),
            width = vim.fn.float2nr(vim.o.columns),
            border = "none",
        })
    end
}

