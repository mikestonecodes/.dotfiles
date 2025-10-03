return {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {
		-- Optional settings
	},
	config = function()
		require("roslyn").setup({
			auto_import = true, -- automatically add missing usings
			organize_imports_on_save = true, -- optional: cleans up usings when saving
			-- Configuration options
		})

		-- Configure roslyn LSP
		vim.lsp.config("roslyn", {
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
			},
		})
	end,
}
