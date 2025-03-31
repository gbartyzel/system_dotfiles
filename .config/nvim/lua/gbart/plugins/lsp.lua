return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			keys = {
				{
					"<leader>m",
					"<cmd>Mason<cr>",
					mode = "n",
				},
			},
			config = true,
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true }),
			desc = "LSP actions",
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf })
				end

				map("K", "<cmd>lua vim.lsp.buf.hover()<cr>")
				map("gd", require("fzf-lua").lsp_definitions, "Go to definition")
				map("gD", require("fzf-lua").lsp_declarations, "Go to declaration")
				map("gi", require("fzf-lua").lsp_implementations, "Go to implementation")
				map("go", require("fzf-lua").lsp_typedefs, "Go to type definition")
				map("gr", require("fzf-lua").lsp_references, "Go to references")
				map("gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
				map("\\w", require("fzf-lua").lsp_live_workspace_symbols, "Workspace symbols")
				map("\\d", require("fzf-lua").lsp_document_symbols, "Document symbols")
				map("\\r", "<cmd>lua vim.lsp.buf.rename()<cr>")
				map("\\a", require("fzf-lua").lsp_code_actions, "Code actions")
				map("gl", require("fzf-lua").lsp_document_diagnostics, "Document diagnostics")
				map("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
				map("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			end,
		})

		require("mason").setup({
			ui = { border = "rounded" },
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

		require("mason-tool-installer").setup({
			ensure_installed = {
				"buildifier",
				"bzl",
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
		})

		local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
		lsp_capabilities =
			vim.tbl_deep_extend("force", lsp_capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, lsp_capabilities, server.capabilities or {})
					-- server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
