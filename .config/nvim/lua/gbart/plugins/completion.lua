return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {

			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")

			cmp.setup({
				completion = { completeopt = "menu,menuone,noinsert" },

				sources = cmp.config.sources({
					-- { name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "path", group_index = 2 },
					{ name = "luasnip", group_index = 2 },
				}, {
					{ name = "buffer" },
				}),
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(5),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			})
		end,
	},
	{
		"github/copilot.vim",
	},
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	dependencies = { "zbirenbaum/copilot.lua", config = true },
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
-- return {
-- 	"saghen/blink.cmp",
-- 	version = "v0.*",
-- 	-- !Important! Make sure you're using the latest release of LuaSnip
-- 	-- `main` does not work at the moment
-- 	dependencies = { { "L3MON4D3/LuaSnip", version = "v2.*" }, "rafamadriz/friendly-snippets" },
-- 	opts = {
-- 		snippets = {
-- 			expand = function(snippet)
-- 				require("luasnip").lsp_expand(snippet)
-- 			end,
-- 			active = function(filter)
-- 				if filter and filter.direction then
-- 					return require("luasnip").jumpable(filter.direction)
-- 				end
-- 				return require("luasnip").in_snippet()
-- 			end,
-- 			jump = function(direction)
-- 				require("luasnip").jump(direction)
-- 			end,
-- 		},
-- 		sources = {
-- 			default = { "lsp", "path", "luasnip", "buffer" },
-- 		},
-- 	},
-- }
