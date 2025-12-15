return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_fallback = true, timeout_ms = 500 })
			end,
			mode = "",
			desc = "[F]ormat file",
		},
		{
			"<leader>tf",
			function()
				if vim.b.disable_autoformat then
					vim.cmd("EnableAutoformat")
					vim.notify("Autoformat enabled for this buffer", vim.log.levels.INFO)
				else
					vim.cmd("DisableAutoformat!")
					vim.notify("Autoformat disabled for this buffer", vim.log.levels.INFO)
				end
			end,
			desc = "Toggle autoformat for [f]ile",
		},
		{
			"<leader>tF",
			function()
				if vim.g.disable_autoformat then
					vim.cmd("EnableAutoformat")
					vim.notify("Autoformat enabled globally", vim.log.levels.INFO)
				else
					vim.cmd("DisableAutoformat!")
					vim.notify("Autoformat disabled globally", vim.log.levels.INFO)
				end
			end,
			desc = "Toggle autoformat for [F]iles globally",
		},
	},
	config = function()
		local conform = require("conform")

		local config_file_name = ".conform.json"
		local default = {
			formatters = {
				lua = { "stylua" },
				python = { "isort", "black" },
				cpp = { "clang-format" },
				yaml = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
			},
			args = {},
		}

		local config_cache = {}

		local load_config = function(bufnr)
			local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":h")
			local git_root = vim.fn.systemlist("git -C " .. path .. " rev-parse --show-toplevel")[1]

			if vim.v.shell_error ~= 0 or git_root == "" then
				return nil
			end

			-- Return cached config if available
			if config_cache[git_root] then
				return config_cache[git_root]
			end

			local config_file = git_root .. "/" .. config_file_name
			if vim.fn.filereadable(config_file) == 0 then
				return nil
			end

			local res_read, config_content = pcall(vim.fn.readfile, config_file)
			if not res_read or not config_content then
				vim.notify("Error reading conform config file", vim.log.levels.ERROR)
				return nil
			end

			local res_parse, parsed_config = pcall(vim.fn.json_decode, table.concat(config_content, "\n"))
			if not res_parse then
				vim.notify("Error parsing conform config file", vim.log.levels.ERROR)
				return nil
			end

			local result = {
				formatters = parsed_config.formatters,
				args = parsed_config.args or {},
			}
			config_cache[git_root] = result
			return result
		end

		-- Initialize conform with default formatters
		conform.setup({
			formatters_by_ft = default.formatters,
		})

		local original_format = conform.format

		conform.format = function(opts)
			local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
			local config = load_config(bufnr) or default

			conform.formatters_by_ft = config.formatters
			for fmt, args in pairs(config.args) do
				conform.formatters[fmt] = conform.formatters[fmt] or {}
				conform.formatters[fmt].prepend_args = function()
					return args
				end
			end

			original_format(opts)
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				if not vim.g.disable_autoformat and not vim.b[args.buf].disable_autoformat then
					local ok, err = pcall(function()
						require("conform").format({ bufnr = args.buf, lsp_fallback = true, timeout_ms = 500 })
					end)
					if not ok then
						vim.notify("Formatting error: " .. tostring(err), vim.log.levels.ERROR)
					end
				end
			end,
		})

		vim.api.nvim_create_user_command("EnableAutoformat", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Enable autoformatting on save",
		})

		vim.api.nvim_create_user_command("DisableAutoformat", function(args)
			if args.bang then
				vim.g.disable_autoformat = true
			else
				vim.b.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformatting on save (use ! to disable globally)",
			bang = true,
		})
	end,
}
