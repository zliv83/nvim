local wk = require("which-key")

wk.add({
	{ "<leader>g", group = "Git" },
	{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log", mode = { "n" } },
	{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status", mode = { "n" } },
	{ "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "Git Issues", mode = { "n" } },
	{ "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "Git Issues All", mode = { "n" } },
	{ "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub PRs", mode = { "n" } },
	{ "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub PRs (all)", mode = { "n" } },
	{ "<leader>gf", function() Snacks.picker.git_files() end, desc = "Git tracked files", mode = { "n" } },
})
