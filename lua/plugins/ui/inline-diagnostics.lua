return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "minimal",
			options = {
				show_code = false,
				show_all_diags_on_cursorline = true,
				add_messages = {
					use_max_severity = true,
				},
				multilines = {
					enabled = true,
					always_show = true,
					trim_whitespaces = true,
				},
			},
		})
		vim.diagnostic.config({ virtual_text = false })
	end,
}
