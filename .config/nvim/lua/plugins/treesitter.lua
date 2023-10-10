
return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "lua",
                "javascript",
                "typescript",
                "python",
                "tsx",
                "css",
                "json",
                "fish",
                "html",
				"vim",
				"vimdoc",
				"query"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		}
    end
}
