return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	---@class wk.Opts
	opts = {
		delay = 500,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		-- Shared keybinds (both environments)
		require("config.keybinds.shared")

		-- Terminal-only keybinds
		if not vim.g.vscode then
			require("config.keybinds.general")
			require("config.keybinds.find")
			require("config.keybinds.search")
			require("config.keybinds.git")
			require("config.keybinds.terminal")
			require("config.keybinds.buffers")
			require("config.keybinds.npm")
		end
	end,
	keys = {
		{
			"<leader>?",
			function() require("which-key").show({ global = false }) end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
