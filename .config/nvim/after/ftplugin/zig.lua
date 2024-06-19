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
  callback = function(event)
    local qflist = vim.fn.getqflist()
    local diagnostics = vim.diagnostic.fromqflist(qflist)
	for _, diagnostic in ipairs(diagnostics) do
      diagnostic.message = diagnostic.message:sub(9)
    end
    vim.diagnostic.reset(ns, event.buf) -- don't actually know if this is necessary, fafo
    vim.diagnostic.set(ns, event.buf, diagnostics)
  end,
})
vim.cmd("silent! make! | redraw!")
vim.g.zig_fmt_autosave = 0
