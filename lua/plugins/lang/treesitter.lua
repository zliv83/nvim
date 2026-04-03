return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- 1. Tell the plugin exactly which parsers to fetch
			require("nvim-treesitter").install({
				"astro",
				"html",
				"html_tags",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"lua",
			})

			-- 2. Manually enable Neovim's native treesitter highlighting for these files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "astro", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "lua" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
