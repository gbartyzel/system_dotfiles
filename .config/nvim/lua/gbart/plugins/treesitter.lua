return {
	-- Treesitter: parser management and queries
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()

			-- Install parsers (async, non-blocking)
			require("nvim-treesitter").install({
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
			})

			-- Enable treesitter highlighting and indentation for all filetypes
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	-- Treesitter text objects: select, move, swap
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
				move = {
					set_jumps = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")

			-- Select text objects
			for _, mode in ipairs({ "x", "o" }) do
				vim.keymap.set(mode, "af", function()
					select.select_textobject("@function.outer", "textobjects")
				end, { desc = "Select around function" })
				vim.keymap.set(mode, "if", function()
					select.select_textobject("@function.inner", "textobjects")
				end, { desc = "Select inside function" })
				vim.keymap.set(mode, "ac", function()
					select.select_textobject("@class.outer", "textobjects")
				end, { desc = "Select around class" })
				vim.keymap.set(mode, "ic", function()
					select.select_textobject("@class.inner", "textobjects")
				end, { desc = "Select inside class" })
				vim.keymap.set(mode, "aa", function()
					select.select_textobject("@parameter.outer", "textobjects")
				end, { desc = "Select around argument" })
				vim.keymap.set(mode, "ia", function()
					select.select_textobject("@parameter.inner", "textobjects")
				end, { desc = "Select inside argument" })
				vim.keymap.set(mode, "al", function()
					select.select_textobject("@loop.outer", "textobjects")
				end, { desc = "Select around loop" })
				vim.keymap.set(mode, "il", function()
					select.select_textobject("@loop.inner", "textobjects")
				end, { desc = "Select inside loop" })
				vim.keymap.set(mode, "ai", function()
					select.select_textobject("@conditional.outer", "textobjects")
				end, { desc = "Select around conditional" })
				vim.keymap.set(mode, "ii", function()
					select.select_textobject("@conditional.inner", "textobjects")
				end, { desc = "Select inside conditional" })
			end

			-- Move to next/previous text objects
			for _, mode in ipairs({ "n", "x", "o" }) do
				vim.keymap.set(mode, "]f", function()
					move.goto_next_start("@function.outer", "textobjects")
				end, { desc = "Next function start" })
				vim.keymap.set(mode, "]c", function()
					move.goto_next_start("@class.outer", "textobjects")
				end, { desc = "Next class start" })
				vim.keymap.set(mode, "]a", function()
					move.goto_next_start("@parameter.inner", "textobjects")
				end, { desc = "Next argument" })
				vim.keymap.set(mode, "]F", function()
					move.goto_next_end("@function.outer", "textobjects")
				end, { desc = "Next function end" })
				vim.keymap.set(mode, "]C", function()
					move.goto_next_end("@class.outer", "textobjects")
				end, { desc = "Next class end" })
				vim.keymap.set(mode, "[f", function()
					move.goto_previous_start("@function.outer", "textobjects")
				end, { desc = "Previous function start" })
				vim.keymap.set(mode, "[c", function()
					move.goto_previous_start("@class.outer", "textobjects")
				end, { desc = "Previous class start" })
				vim.keymap.set(mode, "[a", function()
					move.goto_previous_start("@parameter.inner", "textobjects")
				end, { desc = "Previous argument" })
				vim.keymap.set(mode, "[F", function()
					move.goto_previous_end("@function.outer", "textobjects")
				end, { desc = "Previous function end" })
				vim.keymap.set(mode, "[C", function()
					move.goto_previous_end("@class.outer", "textobjects")
				end, { desc = "Previous class end" })
			end

			-- Swap arguments
			vim.keymap.set("n", "<leader>sa", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Swap with next argument" })
			vim.keymap.set("n", "<leader>sA", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Swap with previous argument" })
		end,
	},

	-- Treesitter context: show code context at top of screen
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
}
