local wk = require("which-key")

wk.add({
	{ "<leader>f", group = "Find" },
	{ "<leader>ff", function() Snacks.picker.files({ cwd = vim.fn.getcwd() }) end, desc = "Find Files", mode = { "n" } },
	{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Git Files", mode = { "n" } },
	{ "<leader>fs", "<cmd>SearchBoxIncSearch<cr>", desc = "Search in file", mode = { "n" } },
	{ "<leader>fr", "<cmd>SearchBoxReplace<cr>", desc = "Search and Replace in file", mode = { "n" } },
})
