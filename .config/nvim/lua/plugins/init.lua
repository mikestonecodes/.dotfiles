return {

	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		opts = {
			hints = { enabled = false },
		},
		build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to setup it properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
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
