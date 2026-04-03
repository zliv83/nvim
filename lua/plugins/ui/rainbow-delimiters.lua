return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		-- highlight groups are defined in indent.lua (shared Rainbow* groups)
		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = "rainbow-delimiters.strategy.global",
				vim = "rainbow-delimiters.strategy.local",
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
				html = "rainbow-delimiters",
			},
			priority = {
				[""] = 110,
				lua = 210,
				html = 210,
			},
		}
	end,
}
