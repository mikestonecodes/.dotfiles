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
		local qflist = vim.fn.getqflist()
		local diagnostics_by_buf = vim.diagnostic.fromqflist(qflist)

		for _, diagnostic in ipairs(diagnostics_by_buf) do
			vim.diagnostic.set(ns, diagnostic.bufnr, { diagnostic })
		end

		vim.schedule(function()
			local total_errors = 0
			local current_bufnr = vim.api.nvim_get_current_buf()

			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if bufnr ~= current_bufnr then
					total_errors = total_errors + #vim.diagnostic.get(bufnr)
				end
			end

			vim.cmd(total_errors > 0 and "Trouble" or "TroubleClose")
		end)
	end,
})
vim.g.zig_fmt_autosave = 0
vim.cmd("silent! make! | redraw!")
