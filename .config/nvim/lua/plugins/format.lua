-- Autoformat
-- TODO: add toggle auto-format (and other advanced features in readmes)
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
-- todo?: (add nvim-lint package)
return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        { "<leader>of", "<cmd>ConformInfo<cr>", desc = "Formatting (Conform)" }
    },
    config = function()
        require("conform").setup({
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { "isort", "black" },
                rust = { "rustfmt" },
                -- You can use a sub-list to tell conform to run *until* a formatter is found.
                -- javascript = { { "prettierd", "prettier" } },
            },
        })

        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
