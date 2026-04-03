return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "cargo build --release",
	opts = {
		keymap = { preset = "super-tab" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = false },
			keyword = {
				-- Astro template expressions behave better when matching only text before the cursor.
				range = "prefix",
			},
			trigger = {
				show_on_x_blocked_trigger_characters = function()
					if vim.bo.filetype == "astro" then
						return { "'", '"', "(" }
					end

					return { "'", '"', "(", "{", "[" }
				end,
			},
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
			providers = {
				lsp = {
					transform_items = function(_, items)
						if vim.bo.filetype ~= "astro" then
							return items
						end

						return vim.tbl_filter(function(item)
							return item.detail ~= "Emmet Abbreviation"
						end, items)
					end,
				},
			},
		},
		fuzzy = { implementation = "rust" },
	},
	config = function(_, opts)
		require("blink.cmp").setup(opts)

		local blink_cmp_group = vim.api.nvim_create_augroup("BlinkCmpTweaks", { clear = true })
		local astro_expr_group = vim.api.nvim_create_augroup("AstroExpressionCompletion", { clear = true })

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = blink_cmp_group,
			once = true,
			callback = function()
				-- Re-register blink's insert-mode listener after InsertEnter lazy-loaders like nvim-autopairs.
				vim.schedule(function() require("blink.cmp").resubscribe() end)
			end,
		})

		local function should_trigger_astro_expression_completion()
			if vim.bo.filetype ~= "astro" then
				return false
			end

			local mode = vim.api.nvim_get_mode().mode
			if not mode:match("^i") then
				return false
			end

			local cursor = vim.api.nvim_win_get_cursor(0)
			local before_cursor = vim.api.nvim_get_current_line():sub(1, cursor[2])
			local open_brace = before_cursor:match(".*(){" )
			local close_brace = before_cursor:match(".*()}")

			if not open_brace or (close_brace and close_brace > open_brace) then
				return false
			end

			local expr = before_cursor:sub(open_brace + 1)
			return expr:match("[%a_][%w_]*$") ~= nil or expr:match("[%a_][%w_%.]*%.$") ~= nil
		end

		vim.api.nvim_create_autocmd("TextChangedI", {
			group = astro_expr_group,
			callback = function()
				if not should_trigger_astro_expression_completion() then
					return
				end

				vim.schedule(function()
					if not should_trigger_astro_expression_completion() then
						return
					end

					local cmp = require("blink.cmp")
					if not cmp.is_menu_visible() then
						cmp.show({ providers = { "lsp" } })
					end
				end)
			end,
		})
	end,
	opts_extend = { "sources.default" },
}
