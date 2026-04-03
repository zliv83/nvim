local function enable_transparency()
	local hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	hl.bg = nil
	vim.api.nvim_set_hl(0, "Normal", hl)
end
return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox")
			enable_transparency()
		end,
	},
	-- {
	-- "kepano/flexoki-neovim",
	-- lazy = false,
	-- priority = 1000,
	-- name = "flexoki",
	-- config = function()
	-- vim.cmd.colorscheme("flexoki")
	-- enable_transparency()
	-- end,
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			theme = "gruvbox",
		},
	},
}
