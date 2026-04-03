local wk = require("which-key")

wk.add({
	-- ── General ─────────────────────────────────────
	{ "<C-s>", "<cmd>w<cr>", desc = "Save (Ctrl+S)", mode = { "i" } },
	{ "<leader>w", "<cmd>w<cr>", desc = "Save in normal mode 🥞", mode = { "n" } },
	{ "<leader>q", "<cmd>q<cr>", desc = "Quit", mode = { "n", "v" } },
	{ "<leader>wq", "<cmd>wq<cr>", desc = "Write and Quit", mode = { "n", "v" } },
	{ "<leader>/", "<cmd>normal gcc<cr>", desc = "Toggle Comment", mode = { "n" } },
	{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer", mode = { "n" } },
	{ "<leader>j", "<cmd>put _<cr>", desc = "Blank line blow", mode = { "n" } },
	{ "<leader>k", "<cmd>put! _<cr>", desc = "Blank line above", mode = { "n" } },
	{ "<leader>nh", "<cmd>nohls<cr>", desc = "No HLS", mode = { "n" } },

	-- ── Insert Mode ─────────────────────────────────
	{ "jj", "<esc>", desc = "Exit insert", mode = { "i" } },
	{ "<S-CR>", "<esc>o", desc = "Go to newline underneath current line", mode = { "i" } },
	{ "<C-z>", "<cmd>undo<cr>", desc = "Undo", mode = { "i" } },
	{ "<C-S-z>", "<cmd>redo<cr>", desc = "Redo", mode = { "i" } },

	-- ── Window Navigation ───────────────────────────
	{ "<C-h>", "<cmd>wincmd h<cr>", desc = "Focus window left", mode = { "n", "t", "i" } },
	{ "<C-j>", "<cmd>wincmd j<cr>", desc = "Focus window down", mode = { "n", "t", "i" } },
	{ "<C-k>", "<cmd>wincmd k<cr>", desc = "Focus window up", mode = { "n", "t", "i" } },
	{ "<C-l>", "<cmd>wincmd l<cr>", desc = "Focus window right", mode = { "n", "t", "i" } },

	-- ── LSP ─────────────────────────────────────────
	{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Go to Definition", mode = { "n" } },
	{ "gr", function() Snacks.picker.lsp_references() end, desc = "LSP References", mode = { "n" } },
	{ "ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", mode = { "n" } },
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Actions", mode = { "n" } },
})
