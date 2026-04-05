if vim.g.vscode then
	require("config.keybinds.vscode")
else
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.cursorline = true
	vim.opt.termguicolors = true
	vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
	vim.keymap.set("i", "<D-cr>", "<C-o>O", { desc = "New line below (Cmd+Enter)" })
end

-- Shared Settings (Both Environments)
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

require("config.lazy")
