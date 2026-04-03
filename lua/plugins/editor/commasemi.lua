return {
	"saifulapm/commasemi.nvim",
	lazy = false,
	opts = {
		keymaps = true,
		commands = true,
	},
	config = function(_, opts)
		local commasemi = require("commasemi")
		commasemi.setup(opts)

		local function toggle_and_newline(char)
			commasemi.toggle(char)
			local keys = vim.api.nvim_replace_termcodes("<Esc>o", true, false, true)
			vim.api.nvim_feedkeys(keys, "n", false)
		end

		vim.keymap.set("i", "<localleader>;", function() toggle_and_newline(";") end, { desc = "Toggle semicolon and newline" })
		vim.keymap.set("i", "<localleader>,", function() toggle_and_newline(",") end, { desc = "Toggle comma and newline" })
	end,
}
