-- Folke's collection of QoL improvements
-- (Essential ones = 🚨)
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- UI
        notifier = { enabled = true }, -- 🚨notifications + notif history, instead of line
        input = { enabled = true },    -- 🚨pretty nvim UI with normal mode (e.g. renaming)

        -- functionality (new keybinds)
        gitbrowse = { enabled = true }, -- navigate to git repo's website
        lazygit = { enabled = true },
        toggle = { enabled = true, notify = false },
        rename = { enabled = true }, -- LSP aware file rename

        -- Zen mode
        zen = {
            enabled = true,
            toggles = { dim = false, git_signs = true },
            show = { statusline = false },
            win = { style = "zen" },
        },
        styles = {
            zen = {
                height = 120,
                backdrop = { transparent = false },
                wo = { signcolumn = "no" },
            }
        },
        dim = { enabled = true }, -- dim everything outside of current scope

        -- QoL
        bigfile = { enabled = true },   -- don't attach LSP/TS to big files
        quickfile = { enabled = true }, -- render new file quickly before plugins load

        -- Others
        scope = { enabled = true }, -- indent text objects

        -- To try in the future
        image = { enabled = false }, -- render images (markdown files)
    },
    keys = {
        { "<leader>tR", function() Snacks.rename.rename_file() end,    desc = "Rename file" },

        -- Notifications
        { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        { "<leader>nn", function() Snacks.notifier.hide() end,         desc = "Dismiss Notifications" },

        -- Git + LazyGit
        { "<leader>gg", function() Snacks.lazygit() end,               desc = "lg" },
        { "<leader>gl", function() Snacks.lazygit.log() end,           desc = "lg: log" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "lg: file History" },
        { "<leader>gw", function() Snacks.gitbrowse() end,             desc = "Repo Website",         mode = { "n", "v" } },
        { "<leader>gb", function() Snacks.git.blame_line() end,        desc = "Blame Line" },
    },

    -- Create mappings for Toggle functionality
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>Ts")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>Tw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>TL")
                Snacks.toggle.diagnostics():map("<leader>TD")
                Snacks.toggle.line_number():map("<leader>Tl")
                Snacks.toggle.treesitter():map("<leader>TT")
                Snacks.toggle.inlay_hints():map("<leader>Th")
                Snacks.toggle.dim():map("<leader>Td")
                Snacks.toggle.zen():map("<leader>Tz")
            end,
        })
    end,
}
