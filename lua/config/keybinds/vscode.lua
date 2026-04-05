local vscode = require("vscode")

-- Find / Search (remap to VSCode equivalents)
vim.keymap.set("n", "<leader>ff", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>fg", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>fs", function() vscode.action("actions.find") end)
vim.keymap.set("n", "<leader>fr", function() vscode.action("editor.action.startFindReplaceAction") end)
vim.keymap.set("n", "<leader>sg", function() vscode.action("workbench.action.findInFiles") end)
vim.keymap.set(
	"n",
	"<leader>sw",
	function()
		vscode.action("workbench.action.findInFiles", {
			args = { query = vim.fn.expand("<cword>") },
		})
	end
)

-- Explorer
vim.keymap.set("n", "<leader>e", function() vscode.action("workbench.view.explorer") end)

-- LSP (already works via extension, but explicit remaps are cleaner)
vim.keymap.set("n", "gr", function() vscode.action("editor.action.goToReferences") end)
vim.keymap.set("n", "ss", function() vscode.action("workbench.action.gotoSymbol") end)

-- Buffers → Editors
vim.keymap.set("n", "<leader>,", function() vscode.action("workbench.action.showAllEditors") end)
vim.keymap.set("n", "<leader>bd", function() vscode.action("workbench.action.closeActiveEditor") end)
vim.keymap.set("n", "<leader>bD", function() vscode.action("workbench.action.closeAllEditors") end)
vim.keymap.set("n", "<leader>bo", function() vscode.action("workbench.action.closeOtherEditors") end)

-- Git (use VSCode's built-in SCM)
vim.keymap.set("n", "<leader>gs", function() vscode.action("workbench.view.scm") end)
vim.keymap.set("n", "<leader>gl", function() vscode.action("git.viewHistory") end)

-- Toggle (repurpose <leader>t for VSCode UI toggles)
vim.keymap.set("n", "<leader>tt", function() vscode.action("workbench.action.terminal.toggleTerminal") end)
vim.keymap.set("n", "<leader>tp", function() vscode.action("workbench.action.togglePanel") end)
vim.keymap.set("n", "<leader>ts", function() vscode.action("workbench.action.toggleSidebarVisibility") end)
vim.keymap.set("n", "<leader>tc", function() vscode.action("workbench.action.toggleAuxiliaryBar") end)
