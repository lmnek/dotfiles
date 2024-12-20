-- Autoformat
return {
    'stevearc/conform.nvim',
    -- lazy loading
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = { { "<leader>of", "<cmd>ConformInfo<cr>", desc = "Formatting (Conform)" } },
    opts = {
        notify_on_error = false,
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { "black" },
            -- You can use a sub-list to tell conform to run *until* a formatter is found.
            javascript = { { "prettierd", "prettier" } },
        },
    },
}
