local wk = require("which-key")
local terms = require("config.terms")

wk.add({
	{ "<leader>t", group = "Terminal" },
	{ "<leader>tb", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "New Terminal", mode = { "n", "t" } },
	{ "<leader>t1", "<cmd>1ToggleTerm direction=horizontal<cr>", desc = "Terminal 1", mode = { "n", "t" } },
	{ "<leader>t2", "<cmd>2ToggleTerm direction=horizontal<cr>", desc = "Terminal 2", mode = { "n", "t" } },
	{ "<leader>t3", "<cmd>3ToggleTerm direction=horizontal<cr>", desc = "Terminal 3", mode = { "n", "t" } },
	{
		"<leader>tr",
		function() terms.claude:toggle() end,
		desc = "Toggle Claudy Claude",
		mode = { "n", "t" },
	},
	{
		"<leader>tcr",
		function() terms.cargorun:toggle() end,
		desc = "Toggle Cargo Run",
		mode = { "n" },
	},
	{ "<leader>x", group = "Xmake" },
	{ "<leader>xr", group = "Run" },
	{
		"<leader>xrr",
		function() terms.xmakerun_release:toggle() end,
		desc = "Run (Release)",
		mode = { "n" },
	},
	{
		"<leader>xrd",
		function() terms.xmakerun_debug:toggle() end,
		desc = "Run (Debug)",
		mode = { "n" },
	},
	{ "<leader>u", group = "UV" },
	{
		"<leader>uv",
		function() terms.uvrunpython:toggle() end,
		desc = "UV run cwd main.py",
		mode = { "n" },
	},
	{ "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select Terminal", mode = { "n", "t" } },
	{ "<leader>cc", function() terms.compilec() end, desc = "Compile and run c file", mode = { "n" } },
	{
		"<leader>cci",
		function() terms.compilec_interactive() end,
		desc = "Compile and run c (interactive)",
		mode = { "n" },
	},
})
