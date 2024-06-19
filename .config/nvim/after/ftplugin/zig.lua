-- after/ftplugin/zig.lua

local ns = vim.api.nvim_create_namespace("zig-on-save")
local group = vim.api.nvim_create_augroup("zig-on-save", { clear = true })
local buffer = vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	buffer = buffer,
	command = "silent! make! | redraw!",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	group = group,
	buffer = buffer,
	callback = function()
		vim.schedule(function()
			local qflist = vim.fn.getqflist()
			local diagnostics_by_buf = vim.diagnostic.fromqflist(qflist)

			local total_errors = 0
			vim.diagnostic.reset()
			for _, diagnostic in ipairs(diagnostics_by_buf) do
				vim.diagnostic.set(ns, diagnostic.bufnr, { diagnostic })
				total_errors = total_errors + 1
			end

			vim.cmd(total_errors > 0 and "Trouble" or "TroubleClose")
		end)
	end,
})
vim.g.zig_fmt_autosave = 0
vim.cmd("silent! make! | redraw!")
