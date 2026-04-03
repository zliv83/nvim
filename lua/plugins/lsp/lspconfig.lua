return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local lspconfig_util = require("lspconfig.util")

		local function global_tsdk()
			local overrides = { vim.g.astro_tsdk, vim.g.tsdk }

			for _, path in ipairs(overrides) do
				if type(path) == "string" and path ~= "" and vim.fn.isdirectory(path) == 1 then return path end
			end

			local tsserver = vim.fn.exepath("tsserver")
			if tsserver == "" then return nil end

			local realpath = vim.uv.fs_realpath(tsserver) or tsserver
			local candidates = {
				realpath:gsub("/bin/tsserver$", "/lib/node_modules/typescript/lib"),
				realpath:gsub("/lib/node_modules/typescript/bin/tsserver$", "/lib/node_modules/typescript/lib"),
			}

			for _, path in ipairs(candidates) do
				if path ~= realpath and vim.fn.isdirectory(path) == 1 then return path end
			end
		end

		local function astro_tsdk(root_dir)
			if root_dir and root_dir ~= "" then
				local project_tsdk = lspconfig_util.get_typescript_server_path(root_dir)
				if project_tsdk ~= "" then return project_tsdk end
			end

			return global_tsdk()
		end

		-- Web servers
		vim.lsp.config("html", { capabilities = capabilities })
		vim.lsp.config("cssls", { capabilities = capabilities })
		vim.lsp.config("ts_ls", { capabilities = capabilities })
		vim.lsp.config("emmet_language_server", {
			capabilities = capabilities,
			filetypes = {
				"css",
				"eruby",
				"html",
				"htmlangular",
				"htmldjango",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"svelte",
				"typescriptreact",
				"vue",
			},
		})
		vim.lsp.config("astro", {
			capabilities = capabilities,
			-- Prefer project TypeScript, then fall back to a user/global install.
			before_init = function(init_params, config)
				local root_dir = config.root_dir
				if (not root_dir or root_dir == "") and init_params.rootUri and init_params.rootUri ~= vim.NIL then
					root_dir = vim.uri_to_fname(init_params.rootUri)
				end

				local tsdk = astro_tsdk(root_dir)
				if not tsdk then return end

				init_params.initializationOptions = init_params.initializationOptions or {}
				init_params.initializationOptions.typescript = init_params.initializationOptions.typescript or {}
				init_params.initializationOptions.typescript.tsdk = tsdk

				config.init_options = init_params.initializationOptions
			end,
		})

		vim.lsp.enable({ "html", "cssls", "ts_ls", "emmet_language_server", "astro" })

		-- Lua (for editing this config) — lazydev.nvim provides Neovim API types
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					telemetry = { enable = false },
					diagnostics = {
						globals = {
							-- xmake DSL globals (description scope)
							"add_rules",
							"target",
							"set_kind",
							"set_basename",
							"set_extension",
							"set_targetdir",
							"set_objectdir",
							"set_configdir",
							"add_files",
							"del_files",
							"add_deps",
							"add_includedirs",
							"add_defines",
							"add_undefines",
							"add_cflags",
							"add_cxflags",
							"add_cxxflags",
							"add_ldflags",
							"add_shflags",
							"add_frameworks",
							"add_syslinks",
							"add_links",
							"add_linkdirs",
							"set_languages",
							"set_toolchains",
							"set_plat",
							"set_arch",
							"set_symbols",
							"set_optimize",
							"set_warnings",
							"set_pcxxheader",
							"add_requires",
							"add_packages",
							"includes",
							"option",
							"set_default",
							"set_description",
							"add_headerfiles",
							"set_license",
							"set_version",
							-- xmake script scope hooks
							"on_load",
							"on_build",
							"before_build",
							"after_build",
							"on_run",
							"before_run",
							"after_run",
							"on_package",
							"before_package",
							"after_package",
							"on_install",
							"before_install",
							"after_install",
						},
					},
				},
			},
		})

		vim.lsp.enable("lua_ls")

		-- Python
		vim.lsp.config("ruff", {
			capabilities = capabilities,
			on_attach = function(client, _)
				-- Defer hover to Ty: Disable Ruff's hover so they don't double-popup
				client.server_capabilities.hoverProvider = false
			end,
		})
		vim.lsp.config("ty", { capabilities = capabilities })
		vim.lsp.enable({ "ruff", "ty" })

		-- C
		vim.lsp.config("clangd", { capabilities = capabilities })
		vim.lsp.enable("clangd")
	end,
}
