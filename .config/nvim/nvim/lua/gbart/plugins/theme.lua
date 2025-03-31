return {
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup()
			vim.cmd([[colorscheme gruvbox]])
			vim.o.background = "dark"
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			color_icons = true,
			variant = "dark",
		},
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				mode = "buffers",
				diagnostics = "nvim_lsp",
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				separator_style = "slant",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			icons_enabled = true,
			theme = "gruvbox",
			section_separators = { "", "" },
			component_separators = { "", "" },
		},
	},
}
