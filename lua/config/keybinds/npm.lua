local wk = require("which-key")

wk.add({
	{ "<leader>n", group = "npm" },
	{
		"<leader>nrd",
		function() require("config.terms").npmrundev:toggle() end,
		desc = "npm run dev",
		mode = { "n" },
	},
})
