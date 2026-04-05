local wk = require("which-key")

wk.add({
	-- ── General ─────────────────────────────────────
	{ "<C-s>", "<cmd>w<cr>", desc = "Save (Ctrl+S)", mode = { "i" } },
	{ "<leader>w", "<cmd>w<cr>", desc = "Save in normal mode 🥞", mode = { "n" } },
	{ "<leader>q", "<cmd>q<cr>", desc = "Quit", mode = { "n", "v" } },
	{ "<leader>wq", "<cmd>wq<cr>", desc = "Write and Quit", mode = { "n", "v" } },
	{ "<leader>/", "gcc", desc = "Toggle Comment", mode = { "n" } },
	{ "<leader>/", "gc", desc = "Toggle Comment", mode = { "v" } },
	{ "<leader>j", "<cmd>put _<cr>", desc = "Blank line blow", mode = { "n" } },
	{ "<leader>k", "<cmd>put! _<cr>", desc = "Blank line above", mode = { "n" } },
	{ "<leader>nh", "<cmd>nohls<cr>", desc = "No HLS", mode = { "n" } },

	-- ── Localleader (;) ─────────────────────────────
	{
		"<localleader>n",
		function()
			local pos = vim.api.nvim_win_get_cursor(0)
			local row, col = pos[1], pos[2]
			local line = vim.api.nvim_get_current_line()
			local before = line:sub(1, col + 1)
			local after = line:sub(col + 2)
			vim.api.nvim_set_current_line(before .. "\\n" .. after)
			vim.api.nvim_win_set_cursor(0, { row, col + 2 })
		end,
		desc = "Insert \\n",
		mode = { "n" },
	},
	{
		"<localleader>n",
		function()
			local pos = vim.api.nvim_win_get_cursor(0)
			local row, col = pos[1], pos[2]
			local line = vim.api.nvim_get_current_line()
			local before = line:sub(1, col)
			local after = line:sub(col + 1)
			vim.api.nvim_set_current_line(before .. "\\n" .. after)
			vim.api.nvim_win_set_cursor(0, { row, col + 2 })
			vim.cmd("startinsert")
			-- nudge cursor right to land after the inserted \n
			local new_col = col + 2
			vim.api.nvim_win_set_cursor(0, { row, new_col })
		end,
		desc = "Insert \\n",
		mode = { "i" },
	},

	-- ── Insert Mode ─────────────────────────────────
	{ "jj", "<esc>", desc = "Exit insert", mode = { "i" } },
	{ "<S-CR>", "<esc>o", desc = "Go to newline underneath current line", mode = { "i" } },
	{ "<C-z>", "<cmd>undo<cr>", desc = "Undo", mode = { "i" } },
	{ "<C-S-z>", "<cmd>redo<cr>", desc = "Redo", mode = { "i" } },

	-- ── LSP ─────────────────────────────────────────
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Actions", mode = { "n" } },
})

-- ── Detached braces (C files) ──────────────────
local function insert_detached_braces()
	vim.cmd("stopinsert")
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local indent = line:match("^(%s*)")
	local sw = vim.bo.shiftwidth
	local et = vim.bo.expandtab
	local tab = et and string.rep(" ", sw) or "\t"
	local inner = indent .. tab
	vim.api.nvim_buf_set_lines(0, row, row, false, {
		indent .. "{",
		inner,
		indent .. "}",
	})
	vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
	vim.cmd("startinsert!")
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function(ev)
		vim.keymap.set({ "n", "i" }, "<localleader>{", insert_detached_braces, {
			buffer = ev.buf,
			desc = "Detached braces",
		})
	end,
})
