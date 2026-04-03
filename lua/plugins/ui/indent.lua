local HIGHLIGHTS = {
	{ highlight = "RainbowRed", color = "#E06C75" },
	{ highlight = "RainbowOrange", color = "#D19A66" },
	{ highlight = "RainbowYellow", color = "#E5C07B" },
	{ highlight = "RainbowGreen", color = "#98C379" },
	{ highlight = "RainbowBlue", color = "#61AFEF" },
	{ highlight = "RainbowCyan", color = "#56B6C2" },
	{ highlight = "RainbowViolet", color = "#C678DD" },
}

local BG_HIGHLIGHTS = {
	{ highlight = "RainbowBgRed", color = "#0E1C27" },
	{ highlight = "RainbowBgOrange", color = "#271810" },
	{ highlight = "RainbowBgYellow", color = "#24141D" },
	{ highlight = "RainbowBgGreen", color = "#212517" },
	{ highlight = "RainbowBgBlue", color = "#1D1521" },
	{ highlight = "RainbowBgCyan", color = "#282114" },
	{ highlight = "RainbowBgViolet", color = "#131E1B" },
}

local function get_highlight_names(highlights)
	local keyset = {}
	for i, highlight in pairs(highlights) do
		keyset[i] = highlight.highlight
	end
	return keyset
end

-- Customize the "ibl" plugin that is already packaged with LazyVim with rainbow colors!
return {
	"lukas-reineke/indent-blankline.nvim",
	---@module "ibl"
	---@diagnostic disable-next-line: undefined-doc-name
	---@type ibl.config
	opts = {
		indent = {
			highlight = get_highlight_names(HIGHLIGHTS),
			char = "",
		},
		whitespace = {
			highlight = get_highlight_names(BG_HIGHLIGHTS),
			remove_blankline_trail = false,
		},
		scope = {
			highlight = get_highlight_names(HIGHLIGHTS),
		},
	},
	config = function(_, opts)
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- fg-only groups
			for _, hl in pairs(HIGHLIGHTS) do
				vim.api.nvim_set_hl(0, hl.highlight, { fg = hl.color })
			end

			--bg-only groups
			for _, hl in pairs(BG_HIGHLIGHTS) do
				vim.api.nvim_set_hl(0, hl.highlight, { bg = hl.color })
			end
		end)
		-- `plugin.main` is "ibl"
		require("ibl").setup(opts)
		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
