return {
	{
		"stevearc/conform.nvim",
		after = { "mason" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				html = { "prettier" },
				python = { "ruff_format" },
				rust = { "rustfmt" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				toml = { "taplo" },
				go = { "goimports", "gofmt" },
				sh = { "shfmt" },
				zig = { "zigfmt" },
				odin = { "lsp" },
				cs = { "lsp" }, -- ✅ use csharpier instead of non-existent "csharp"
			},
			formatters = {
				goimports = {
					prepend_args = { "-local", "github.com/xwjdsh" },
				},
			},
		},
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				desc = "format",
			},
		},
	},
	{
		"zapling/mason-conform.nvim",
		after = { "mason", "conform" },
		opts = {},
	},
}
