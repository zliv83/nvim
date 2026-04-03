local wk = require("which-key")

wk.add({
	{ "<leader>b", group = "Buffers" },
	{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers", mode = { "n" } },
	{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", mode = { "n" } },
	{ "<leader>bD", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers", mode = { "n" } },
	{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers", mode = { "n" } },
})
