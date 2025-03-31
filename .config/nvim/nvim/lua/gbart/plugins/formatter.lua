return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_format = "fallback", async = true })
			end,
			mode = "",
			desc = "[F]ormat file",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			cpp = { "clang-format" },
			cmake = { "cmake_format" },
			yaml = { "prettier" },
			json = { "prettier" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	},
}
