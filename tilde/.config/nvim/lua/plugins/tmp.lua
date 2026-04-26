-- Plugins currently being tested / worked on
return {
    -- {
    --     "epwalsh/obsidian.nvim",
    --     version = "*",
    --     lazy = true,
    --     ft = "markdown",
    --     event = { -- load only in vault
    --         "BufReadPre ~/repos/obsidian/Lemonek/**/*.md",
    --         "BufNewFile ~/repos/obsidian/Lemonek/**/*.md",
    --     },
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     opts = {
    --         workspaces = {
    --             {
    --                 name = "personal",
    --                 path = "~/repos/obsidian/Lemonek",
    --             }
    --         },
    --     },
    -- },

    -- colorful matching parens
    { 'HiPhish/rainbow-delimiters.nvim' },

    -- display color codes in their bg (+ can add blink.cmp integration later)
    { 'brenoprata10/nvim-highlight-colors', opts = {} },

    -- statusline numbers limited for typing numbers only with left hand for j / k jumps
    { 'mluders/comfy-line-numbers.nvim',    opts = {} },

    { "chentoast/marks.nvim",               event = "VeryLazy", opts = {}, },

    -- smart incremental select: "." in visual mode
    -- NOTE: could work, but didnt test it in nvim 0.12 yet
    -- { 'RRethy/nvim-treesitter-textsubjects', opts = {},          config = function() end },

    -- automatic markdown bullet lists + toggle checkbox via "<leader>x"
    { 'bullets-vim/bullets.vim',            opts = {},          config = function() end },

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

    -- note: keybinds clash
    -- {
    --     "folke/flash.nvim",
    --     event = "VeryLazy",
    --     opts = {},
    --     keys = {
    --         { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    --         { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    --         { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    --         { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --         { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    --     },
    -- }
}
