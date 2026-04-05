return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	cond = not vim.g.vscode,
	config = true,
}
