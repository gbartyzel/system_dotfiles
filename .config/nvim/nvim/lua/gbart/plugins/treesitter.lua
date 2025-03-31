return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		-- "nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = function()
		local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
		ts_update()
	end,
	config = function()
		require("nvim-treesitter.install").prefer_git = true
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"bibtex",
				"c",
				"cpp",
				"cuda",
				"cmake",
				"dockerfile",
				"doxygen",
				"python",
				"latex",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
			},
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},
		})
	end,
}
