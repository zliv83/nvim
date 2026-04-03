local wk = require("which-key")

wk.add({
	{ "<leader>s", group = "Search" },
	{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Live Grep", mode = { "n" } },
	{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep Word", mode = { "n" } },
	{ "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers", mode = { "n" } },
})
