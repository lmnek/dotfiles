-- Autoformat
-- todo?: (add nvim-lint package)
return {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        { "<leader>oF", "<cmd>ConformInfo<cr>", desc = "Formatting (Conform)" }
    },
    config = function()
        require("conform").setup({
            notify_on_error = false,
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,

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


        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
                desc = "Disable autoformat-on-save",
                bang = true,
            })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
                desc = "Re-enable autoformat-on-save",
            })
    end,
}
