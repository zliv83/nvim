return {
	"mrcjkb/rustaceanvim",
	version = "^8",
	lazy = false,
	init = function()
		vim.g.rustaceanvim = {
			server = {
				capabilities = function() return require("blink.cmp").get_lsp_capabilities() end,
				default_settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
						check = {
							command = "clippy",
						},
					},
				},
				on_attach = function(_, bufnr)
					local wk = require("which-key")

					wk.add({
						{ "<leader>r", group = "Rust" },
					}, { buffer = bufnr })

					local map = function(key, rustlsp, desc)
						vim.keymap.set("n", "<leader>r" .. key, function() vim.cmd.RustLsp(rustlsp) end, {
							buffer = bufnr,
							silent = true,
							desc = desc,
						})
					end

					-- Code Actions
					map("a", "codeAction", "Code Action")

					-- Hover actions
					map("h", { "hover", "actions" }, "Hover Actions")

					-- Runnables
					map("r", "runnables", "Runnables")

					-- Testables
					map("t", "testables", "Testables")

					-- Explain rust error under cursor
					map("e", "explainError", "Explain Error")

					-- Open Cargo
					map("oc", "openCargo", "Open Cargo")

					-- Expand Macros Recursively
					map("em", "expandMacro", "Expand Macro Recursively")

					-- Open Docs.rs
					map("od", "openDocs", "Open Docs.rs")

					-- Parent Module
					map("pm", "parentModule", "Parent Module")

					-- Join Lines
					map("jl", "joinLines", "Join Lines")

					-- View Syntax Tree
					map("st", "syntaxTree", "View Syntax Tree")
				end,
			},
		}
	end,
}
