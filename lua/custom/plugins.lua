local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"stevearc/resession.nvim",
		lazy = false,
		config = function()
			local resession = require("resession")

			resession.setup({
				autosave = {
					enabled = true,
					interval = 60,
					notify = false,
				},
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc(-1) == 0 then
						resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
					end
				end,
			})
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
				end,
			})
		end,
	},
	{
		"elentok/format-on-save.nvim",
		lazy = true,
		cmd = { "Format" },
		event = { "BufRead" },
		opts = function()
			local formatters = require("format-on-save.formatters")
			return {
				experiments = {
					partial_update = "diff",
				},
				formatter_by_ft = {
					json = formatters.lsp,
					lua = formatters.stylua,
					rust = formatters.lsp,
					sh = formatters.shfmt,
					toml = formatters.lsp,
					yaml = formatters.lsp,
				},
			}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				mapping = {
					["<C-Space>"] = cmp.complete(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})
		end,
	},
}

return plugins
