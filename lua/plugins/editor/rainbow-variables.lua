return {
	"goldos24/rainbow-variables-nvim",
	cond = not vim.g.vscode,
	config = function()
		require("rainbow-variables-nvim").start_with_config({
			reduce_color_collisisons = true,
			semantic_background_colors = false,
			palette = {
				"#4A90E2", -- Electric Blue
				"#34D399", -- Emerald Green
				"#A3E635", -- Lime Punch
				"#FACC15", -- Sunny Yellow
				"#FB923C", -- Vivid Orange
				"#F87171", -- Softened Red
				"#E879F9", -- Bright Orchid
				"#6366F1", -- Indigo Pop
				"#22D3EE", -- Cyan Spark
				"#F472B6", -- Hot Pink
				"#A78BFA", -- Lavender Blue
				"#FB7185", -- Rosebud
				"#FB923C", -- Amber Glow
				"#4ADE80", -- Mint Leaf
				"#818CF8", -- Periwinkle
				"#C084FC", -- Royal Purple
			},
		})
	end,
}
