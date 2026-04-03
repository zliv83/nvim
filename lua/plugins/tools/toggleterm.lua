return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,
	opts = {
		shell = "/bin/zsh",
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		start_in_insert = true,
		persist_size = true,
		persist_mode = true,
		insert_mappings = true,
		terminal_mappings = true,
		auto_scroll = true,
		winbar = {
			enabled = true,
			name_formatter = function(term) return term.name ~= "" and term.name or ("term " .. term.id) end,
		},
	},
}
