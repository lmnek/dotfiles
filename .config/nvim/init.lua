-- clean and inspirational config:
-- https://github.com/dorrajmachai/nvim/tree/main

-- either create lmnk/init.lua with all requires
-- and here require("lmnk")
-- or:
require("lmnk.remap")
require("lmnk.options") -- nvim options

-- lazy.nvim package manager setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- settings for lazy
local opts = {
    ui = {
        border = "single"
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
            },
        }
    }
}

vim.lsp.set_log_level("info")
vim.env.NVIM_LSP_LOG_FILE = "/~/.cache/nvim/nvim-lsp.log"

-- Automatically load from plugins folder
require("lazy").setup('plugins', opts)
