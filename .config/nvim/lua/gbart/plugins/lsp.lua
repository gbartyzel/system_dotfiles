return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mason-org/mason.nvim",
			keys = {
				{
					"<leader>m",
					"<cmd>Mason<cr>",
					mode = "n",
				},
			},
			opts = {
				ui = {
					border = "rounded",
				},
			},
		},
		"mason-org/mason-lspconfig.nvim",
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = {
					"black",
					"clang-format",
					"cpplint",
					"cpptools",
					"cmakelang",
					"isort",
					"luacheck",
					"markdownlint",
					"mypy",
					"prettier",
					"prettierd",
					"ruff",
					"stylua",
					"shfmt",
					"vint",
				},
			},
		},
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true }),
			desc = "LSP actions",
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
				end
				local fzf = require("fzf-lua")
				map("K", vim.lsp.buf.hover, "Hover documentation")
				map("gd", fzf.lsp_definitions, "Go to definition")
				map("gD", fzf.lsp_declarations, "Go to declaration")
				map("gi", fzf.lsp_implementations, "Go to implementation")
				map("go", fzf.lsp_typedefs, "Go to type definition")
				map("gr", fzf.lsp_references, "Go to references")
				map("gs", vim.lsp.buf.signature_help, "Signature help")
				map("<leader>lw", fzf.lsp_live_workspace_symbols, "Workspace symbols")
				map("<leader>ld", fzf.lsp_document_symbols, "Document symbols")
				map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
				map("<leader>la", fzf.lsp_code_actions, "Code actions")
				map("<leader>ll", fzf.diagnostics_document, "Document diagnostics")
				map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("]d", vim.diagnostic.goto_next, "Next diagnostic")
			end,
		})

		local servers = {
			"bashls",
			"clangd",
			"neocmake",
			"dockerls",
			"ltex",
			"lua_ls",
			"marksman",
			"pyright",
			"vimls",
		}

		local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
		lsp_capabilities =
			vim.tbl_deep_extend("force", lsp_capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			handlers = {
				function(server_name)
					vim.lsp.config(server_name, {
						capabilities = lsp_capabilities,
					})
					vim.lsp.enable(server_name)
				end,
			},
		})
	end,
}
