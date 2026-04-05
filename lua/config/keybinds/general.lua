local wk = require("which-key")

wk.add({
	-- ── Explorer ────────────────────────────────────
	{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer", mode = { "n" } },

	-- ── Window Navigation ───────────────────────────
	{ "<C-h>", "<cmd>wincmd h<cr>", desc = "Focus window left", mode = { "n", "t", "i" } },
	{ "<C-j>", "<cmd>wincmd j<cr>", desc = "Focus window down", mode = { "n", "t", "i" } },
	{ "<C-k>", "<cmd>wincmd k<cr>", desc = "Focus window up", mode = { "n", "t", "i" } },
	{ "<C-l>", "<cmd>wincmd l<cr>", desc = "Focus window right", mode = { "n", "t", "i" } },

	-- ── LSP ─────────────────────────────────────────
	{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to Definition", mode = { "n" } },
	{ "gr", function() Snacks.picker.lsp_references() end, desc = "LSP References", mode = { "n" } },
	{ "ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", mode = { "n" } },
})
