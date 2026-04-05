return {
	"VonHeikemen/searchbox.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	cond = not vim.g.vscode,
	opts = {
		defaults = {
			show_matches = "[{match}/{total}]",
			clear_matches = false,
			exact = false,
			modifier = "disabled",
			confirm = "menu",
		},
		popup = {
			relative = "win",
			position = {
				row = "5%",
				col = "95%",
			},
		},
		size = 30,
		border = {
			style = "rounded",
			text = {
				" Search ",
				top_align = "left",
			},
		},
	},
}
