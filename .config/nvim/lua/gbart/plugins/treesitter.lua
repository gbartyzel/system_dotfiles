return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = ":TSUpdate",
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

			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to text-object
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select around function" },
						["if"] = { query = "@function.inner", desc = "Select inside function" },
						["ac"] = { query = "@class.outer", desc = "Select around class" },
						["ic"] = { query = "@class.inner", desc = "Select inside class" },
						["aa"] = { query = "@parameter.outer", desc = "Select around argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inside argument" },
						["al"] = { query = "@loop.outer", desc = "Select around loop" },
						["il"] = { query = "@loop.inner", desc = "Select inside loop" },
						["ai"] = { query = "@conditional.outer", desc = "Select around conditional" },
						["ii"] = { query = "@conditional.inner", desc = "Select inside conditional" },
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- Add jumps to jumplist
					goto_next_start = {
						["]f"] = { query = "@function.outer", desc = "Next function start" },
						["]c"] = { query = "@class.outer", desc = "Next class start" },
						["]a"] = { query = "@parameter.inner", desc = "Next argument" },
					},
					goto_next_end = {
						["]F"] = { query = "@function.outer", desc = "Next function end" },
						["]C"] = { query = "@class.outer", desc = "Next class end" },
					},
					goto_previous_start = {
						["[f"] = { query = "@function.outer", desc = "Previous function start" },
						["[c"] = { query = "@class.outer", desc = "Previous class start" },
						["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
					},
					goto_previous_end = {
						["[F"] = { query = "@function.outer", desc = "Previous function end" },
						["[C"] = { query = "@class.outer", desc = "Previous class end" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sa"] = { query = "@parameter.inner", desc = "Swap with next argument" },
					},
					swap_previous = {
						["<leader>sA"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
					},
				},
			},
		})
	end,
}
