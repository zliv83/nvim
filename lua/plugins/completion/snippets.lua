return {
	"nvim-mini/mini.snippets",
	version = false,
	opts = function()
		local gen = require("mini.snippets").gen_loader
		return {
			snippets = {
				gen.from_file("~/.config/nvim/snippets/global.lua"),
				gen.from_lang(),
			},
		}
	end,
}
