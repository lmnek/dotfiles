
return {
	"Mofiqul/dracula.nvim",
	name = "dracula",
	lazy = false,
	priority = 1000,
	config = function()
		color = color or "dracula" -- "catppuccin"
		vim.cmd.colorscheme(color)

		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
}

