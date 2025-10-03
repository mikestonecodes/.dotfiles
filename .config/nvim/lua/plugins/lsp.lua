return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"zapling/mason-conform.nvim",
		"stevearc/conform.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		})

		-- Helper to start LSP servers with merged defaults
		local function start_server(server, opts)
			local config = vim.tbl_extend("force",
				{},
				vim.lsp.config[server] and vim.lsp.config[server].default_config or {},
				opts or {}
			)
			vim.lsp.start(config)
		end

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"eslint",
				"ols",
				"ts_ls",
			},
			handlers = {
				-- default
				function(server_name)
					start_server(server_name, { capabilities = capabilities })
				end,

				-- lua_ls override
				["lua_ls"] = function()
					start_server("lua_ls", {
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})

		-- Custom server: shader_language_server
		vim.lsp.config.shader_language_server = {
			default_config = {
				cmd = { "/home/mike/.cargo/bin/shader-language-server" },
				filetypes = { "hlsl", "hlsli", "glsl", "frag", "vert" },
				root_dir = vim.fs.root(0, { ".git", "." }),
			},
		}
		start_server("shader_language_server", {
			capabilities = capabilities,
			handlers = { ["$/progress"] = function() end },
		})

		-- nvim-cmp setup
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		vim.opt.completeopt = { "menu", "menuone", "noselect" }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- diagnostics
		vim.diagnostic.config({
			update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

	end,
}
