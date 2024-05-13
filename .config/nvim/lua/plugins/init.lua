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
	{ "echasnovski/mini.surround", version = "*", opts = {} },
	{ "ThePrimeagen/vim-be-good" },
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"stevearc/profile.nvim",
		config = function()
			local should_profile = os.getenv("NVIM_PROFILE")
			if should_profile then
				require("profile").instrument_autocmds()
				if should_profile:lower():match("^start") then
					require("profile").start("*")
				else
					require("profile").instrument("*")
				end
			end

			local function toggle_profile()
				local prof = require("profile")
				if prof.is_recording() then
					prof.stop()
					vim.ui.input(
						{ prompt = "Save profile to:", completion = "file", default = "profile.json" },
						function(filename)
							if filename then
								prof.export(filename)
								vim.notify(string.format("Wrote %s", filename))
							end
						end
					)
				else
					prof.start("*")
				end
			end
			vim.keymap.set("", "<f1>", toggle_profile)
		end,
	},
}
