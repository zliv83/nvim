return {
	"wuelnerdotexe/vim-astro",
	ft = { "astro" },
	init = function()
		-- Keep vim-astro's Astro-specific ftplugin/indent support TS-aware.
		vim.g.astro_typescript = "enable"
	end,
}
