return {

	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	{
		"echasnovski/mini.statusline",
		version = "*",
		opts = {},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				hide = { tabline = true, winbar = true },
				change_to_vcs_root = true,
				config = {
					header = {},
					week_header = { enable = false },
					packages = { enable = false },
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "ThePrimeagen/vim-be-good" },
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
