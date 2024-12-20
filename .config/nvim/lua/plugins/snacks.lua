-- Folke's collection of QoL improvements
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },   -- don't attach LSP/TS to big files
        gitbrowse = { enabled = true }, -- navigate to git repo's website
        lazygit = { enabled = true },
        notifier = { enabled = true },  -- notifications, instead of line
        quickfile = { enabled = true }, -- render new file quickly before plugins load
        dim = { enabled = true },
        toggle = { enabled = true, notify = false },
    },
    keys = {
        -- Notifications
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>nn", function() Snacks.notifier.hide() end,         desc = "Dismiss Notifications" },
        -- Git + LazyGit
        { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
        { "<leader>gl", function() Snacks.lazygit.log() end,           desc = "Lazygit Log (cwd)" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "Lazygit Cur. File History" },
        { "<leader>gw", function() Snacks.gitbrowse() end,             desc = "Repo Website",             mode = { "n", "v" } },
        { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Blame Line" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Create mappings for Toggle functionality
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
                Snacks.toggle.diagnostics():map("<leader>tD")
                Snacks.toggle.line_number():map("<leader>tl")
                Snacks.toggle.treesitter():map("<leader>tT")
                Snacks.toggle.inlay_hints():map("<leader>th")
                Snacks.toggle.dim():map("<leader>td")
            end,
        })
    end,
}
