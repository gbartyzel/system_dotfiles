return {
	{ "christoomey/vim-tmux-navigator" },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = {
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			window = {
				position = "left",
				width = 40,
			},
			filesystem = {
				window = {
					mappings = {
						["<leader>e"] = "close_window",
					},
				},
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter-context",
		},
		keys = {
			{
				"<leader>ff",
				"<cmd>FzfLua files<cr>",
				mode = "n",
				desc = "Fuzzy find files in current directory",
			},
			{
				"<leader>fb",
				"<cmd>FzfLua buffers<cr>",
				mode = "n",
				desc = "Fuzzy find buffers",
			},
			{
				"<leader>ft",
				"<cmd>FzfLua btags<cr>",
				mode = "n",
				desc = "Fuzzy find tags in current buffer",
			},
			{
				"<leader>gc",
				"<cmd>FzfLua git_commits<cr>",
				mode = "n",
				desc = "Fuzzy find git commits",
			},
			{
				"<leader>gs",
				"<cmd>FzfLua git_status<cr>",
				mode = "n",
				desc = "Fuzzy find git status",
			},
			{
				"<leader>gb",
				"<cmd>FzfLua git_branches<cr>",
				mode = "n",
				desc = "Fuzzy find git branches",
			},
		},
	},
}
