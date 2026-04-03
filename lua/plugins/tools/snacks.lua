return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@diagnostic disable-next-line: undefined-doc-name
	---@type snacks.Config
	opts = {
		explorer = {},
		dashboard = {
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Projects",
					section = "projects",
					indent = 2,
					padding = 1,
					dirs = { "~/dev", "~/dev/web", "~/dev/rust", "~/.config" },
				},
				{ section = "startup" },
			},
		},
		picker = {
			sources = {
				explorer = {
					layout = {
						hidden = { "input" },
						layout = { width = 30 },
					},
				},
				gh_issue = {},
				gh_pr = {},
			},
		},
		gh = {},
	},
}
