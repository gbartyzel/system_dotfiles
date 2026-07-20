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

			vim.keymap.set({ "i", "s" }, "<C-n>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true, desc = "LuaSnip expand or jump next" })

			vim.keymap.set({ "i", "s" }, "<C-p>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true, desc = "LuaSnip jump previous" })

			vim.keymap.set({ "i", "s" }, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "LuaSnip cycle choice" })

			cmp.setup({
				completion = { completeopt = "menu,menuone,noinsert" },

				sources = cmp.config.sources({
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
		"milanglacier/minuet-ai.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 512,
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						name = "Ollama",
						end_point = "http://127.0.0.1:11434/v1/completions",
						model = "qwen2.5-coder:1.5b",
						optional = {
							max_tokens = 512,
							top_p = 0.9,
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					auto_trigger_ignore_ft = {},
					keymap = {
						accept = "<C-a>",
						accept_line = "<A-a>",
						next = "<A-n>",
						prev = "<A-p>",
						dismiss = "<A-e>",
					},
					show_on_completion_menu = true,
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			provider = "ollama",
			providers = {
				ollama = {
					endpoint = "http://127.0.0.1:11434",
					model = "ornith:9b",
					timeout = 30000,
					extra_request_body = {
						options = {
							temperature = 0,
							top_p = 0.9,
						},
					},
				},
			},
		},
	},
	-- {
	-- 	"github/copilot.vim",
	-- 	init = function()
	-- 		vim.g.copilot_no_tab_map = true
	-- 		vim.keymap.set("i", "<C-a>", 'copilot#Accept("")', {
	-- 			expr = true,
	-- 			replace_keycodes = false,
	-- 			desc = "Accept Copilot suggestion",
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim", branch = "master" },
	-- 	},
	-- 	build = "make tiktoken",
	-- 	opts = {
	-- 		model = "claude-opus-4.5",
	-- 		temperature = 0.1,
	-- 		window = {
	-- 			layout = "vertical",
	-- 			width = 0.3,
	-- 		},
	-- 		auto_insert_mode = true,
	-- 		mappings = {
	-- 			complete = { insert = "<C-;>" },
	-- 			close = { normal = "<leader>cq", insert = "<C-q>" },
	-- 			reset = { normal = "<leader>cr" },
	-- 			submit_prompt = { normal = "<leader>cs", insert = "<C-s>" },
	-- 			accept_diff = { normal = "<leader>ca", insert = "<C-y>" },
	-- 			jump_to_diff = { normal = "<leader>cj" },
	-- 			quickfix_diffs = { normal = "<leader>cD" },
	-- 			quickfix_answers = { normal = "<leader>cA" },
	-- 			show_diff = { normal = "<leader>cd" },
	-- 			show_info = { normal = "<leader>ci" },
	-- 			show_help = { normal = "<leader>ch" },
	-- 			yank_diff = { normal = "<leader>cy", register = '"' },
	-- 		},
	-- 	},
	-- },
}
