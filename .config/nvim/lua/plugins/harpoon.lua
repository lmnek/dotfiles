return {
    'ThePrimeagen/harpoon',
    opts = {},
    keys = {
        { "<leader>Ha", function() require('harpoon.mark').add_file() end,        desc = "Add file" },
        { "<leader>He", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Open menu" },
        { "<C-h>",      function() require('harpoon.ui').nav_file(1) end },
        { "<C-j>",      function() require('harpoon.ui').nav_file(2) end },
        { "<C-k>",      function() require('harpoon.ui').nav_file(3) end },
        { "<C-l>",      function() require('harpoon.ui').nav_file(4) end },
    }
}

-- return {
--     "ThePrimeagen/harpoon",
--     branch = "harpoon2",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     opts = {
--         menu = {
--             width = vim.api.nvim_win_get_width(0) - 4,
--         },
--         settings = {
--             save_on_toggle = true,
--         },
--     },
--     keys = {
--         { "<leader>Ha", function() require('harpoon'):list():add() end,    desc = "Add file" },
--         {
--             "<leader>He",
--             function()
--                 local h = require('harpoon')
--                 h.ui:toggle_quick_menu(h:list())
--             end,
--             desc = "Open menu"
--         },
--         { "<C-h>",      function() require('harpoon'):list():select(1) end },
--         { "<C-j>",      function() require('harpoon'):list():select(2) end },
--         { "<C-k>",      function() require('harpoon'):list():select(3) end },
--         { "<C-l>",      function() require('harpoon'):list():select(4) end },
--     }
-- }
