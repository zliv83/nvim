local astro_prettier = vim.fn.has("win32") == 1 and "node_modules/.bin/prettier.cmd" or "node_modules/.bin/prettier"

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			rust = { "rustfmt" },
			lua = { "stylua" },
			html = { "biome" },
			css = { "biome" },
			javascript = { "biome" },
			typescript = { "biome" },
			javascriptreact = { "biome" },
			typescriptreact = { "biome" },
			astro = { "prettier_astro" },
			python = { "ruff_fix", "ruff_format" },
			c = { "clang-format" },
		},
		formatters = {
			prettier_astro = {
				inherit = "prettier",
				require_cwd = true,
				condition = function(_, ctx)
					return vim.fs.find(astro_prettier, {
						upward = true,
						path = ctx.dirname,
						limit = 1,
					})[1] ~= nil
				end,
				options = {
					ft_parsers = {
						astro = "astro",
					},
				},
			},
			["clang-format"] = {
				inherit = true,
				prepend_args = {
					"-style=file:" .. vim.fn.stdpath("config") .. "/lua/config/formatters/.clang-format",
				},
			},
			rustfmt = {
				options = {
					nightly = true,
				},
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
