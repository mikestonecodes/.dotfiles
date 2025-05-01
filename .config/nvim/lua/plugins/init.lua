return {

	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "gruvbox",
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
			settings = {
				save_on_toggle = true,
			},
		},
		keys = function()
			local keys = {
				{
					"<leader>a",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon File",
				},
				{
					"<C-e>",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Harpoon Quick Menu",
				},
			}

			local nav_keys = { "j", "k", "l", ";" }
			for i = 1, #nav_keys do
				table.insert(keys, {
					"<C-" .. nav_keys[i] .. ">",
					function()
						require("harpoon"):list():select(i)
					end,
					desc = "Harpoon to File " .. i,
				})
			end
			return keys
		end,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			keymaps = {
				["<C-p>"] = false,
			},
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		opts = {
			hints = { enabled = false },
			cursor_applying_provider = "groq", -- In this example, use Groq for applying, but you can also use any provider you want.
			auto_suggestions_provider = "zeta",
			provider = "claude",
			vendors = {
				zeta = {
					__inherited_from = "openai",
					api_key_name = "",
					endpoint = "http://127.0.0.1:11434/v1",
					model = "zed-industries_zeta",
					disable_tools = true,
				},
				groq = { -- define groq provider
					__inherited_from = "openai",
					api_key_name = "GROQ_API_KEY",
					endpoint = "https://api.groq.com/openai/v1/",
					model = "llama-3.3-70b-versatile",
					max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
				},
			},
			suggestion = {
				debounce = 200,
				throttle = 200,
			},
			behaviour = {
				enable_cursor_planning_mode = true, -- enable cursor planning mode!
				enable_claude_text_editor_tool_mode = true,
				auto_suggestions = true,
			},
		},
		build = "make", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
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
