return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>cl",
			function()
				require("lint").try_lint()
			end,
			mode = "n",
			desc = "[L]int file",
		},
		{
			"<leader>tl",
			function()
				if vim.b.disable_lint then
					vim.cmd("EnableLint")
					vim.notify("Lint enabled for this buffer", vim.log.levels.INFO)
				else
					vim.cmd("DisableLint")
					vim.notify("Lint disabled for this buffer", vim.log.levels.INFO)
				end
			end,
			desc = "Toggle lint for fi[l]e",
		},
		{
			"<leader>tL",
			function()
				if vim.g.disable_lint then
					vim.cmd("EnableLint")
					vim.notify("Lint enabled globally", vim.log.levels.INFO)
				else
					vim.cmd("DisableLint!")
					vim.notify("Lint disabled globally", vim.log.levels.INFO)
				end
			end,
			desc = "Toggle lint for fi[L]es globally",
		},
	},
	config = function()
		local lint = require("lint")

		local config_file_name = ".conform.json"
		local default = {
			linters = {
				cpp = { "cpplint", "clangtidy" },
				python = { "ruff" },
				-- cmake = { "cmakelint" },
				lua = { "luacheck" },
				markdown = { "markdownlint" },
			},
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
				linters = parsed_config.linters or default.linters,
			}
			config_cache[git_root] = result
			return result
		end

		local get_linters_for_ft = function(bufnr)
			local config = load_config(bufnr) or default
			local ft = vim.bo[bufnr].filetype
			return config.linters[ft] or {}
		end

		-- Initialize lint with default linters
		lint.linters_by_ft = default.linters

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function(args)
				if not vim.g.disable_lint and not vim.b[args.buf].disable_lint then
					if vim.opt_local.modifiable:get() then
						local linters = get_linters_for_ft(args.buf)
						lint.try_lint(linters)
					end
				end
			end,
		})

		vim.api.nvim_create_user_command("EnableLint", function(args)
			vim.b.disable_lint = false
			vim.g.disable_lint = false
			local bufnr = args.buf or vim.api.nvim_get_current_buf()
			local linters = get_linters_for_ft(bufnr)
			lint.try_lint(linters)
		end, {
			desc = "Enable linting",
		})

		vim.api.nvim_create_user_command("DisableLint", function(args)
			if args.bang then
				vim.g.disable_lint = true
			else
				vim.b.disable_lint = true
			end
			vim.diagnostic.reset(nil, args.buf or 0)
		end, {
			desc = "Disable linting (use ! to disable globally)",
			bang = true,
		})
	end,
}
