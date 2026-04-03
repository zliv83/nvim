local Terminal = require("toggleterm.terminal").Terminal

local M = {}

local function startinsert(term)
	vim.cmd("startinsert!")
	if not term._auto_insert then
		term._auto_insert = true
		vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
			buffer = term.bufnr,
			callback = function()
				vim.schedule(function() vim.cmd("startinsert!") end)
			end,
		})
	end
end

M.claude = Terminal:new({
	cmd = "claude",
	direction = "vertical",
	dir = vim.fn.getcwd(),
	on_open = startinsert,
})

M.cargorun = Terminal:new({
	cmd = "cargo run",
	direction = "horizontal",
	dir = vim.fn.getcwd(),
	on_open = startinsert,
})

M.xmakerun_release = Terminal:new({
	cmd = "xmake f -m release && xmake run",
	direction = "horizontal",
	dir = vim.fn.getcwd(),
	on_open = startinsert,
})

M.xmakerun_debug = Terminal:new({
	cmd = "xmake f -m debug && xmake run",
	direction = "horizontal",
	dir = vim.fn.getcwd(),
	on_open = startinsert,
})

M.npmrundev = Terminal:new({
	cmd = "npm run dev",
	direction = "horizontal",
	dir = vim.fn.getcwd(),
	hidden = true,
})

M.uvrunpython = Terminal:new({
	cmd = "uv run main.py",
	direction = "horizontal",
	dir = vim.fn.getcwd(),
	on_oopen = startinsert,
	close_on_exit = false,
})

local compilec_term = nil

function M.compilec()
	if compilec_term ~= nil and compilec_term:is_open() then
		compilec_term:toggle()
		return
	end

	local filepath = vim.fn.expand("%:p")
	local dir = vim.fn.fnamemodify(filepath, ":h")
	local file = vim.fn.fnamemodify(filepath, ":t")
	local base = vim.fn.fnamemodify(filepath, ":t:r")

	local cmd = string.format(
		"cd %s && gcc %s -o %s && ./%s",
		vim.fn.shellescape(dir),
		vim.fn.shellescape(file),
		vim.fn.shellescape(base),
		vim.fn.shellescape(base)
	)

	compilec_term = Terminal:new({
		cmd = cmd,
		direction = "horizontal",
		close_on_exit = false,
		on_close = function() vim.cmd("stopinsert") end,
	})
	compilec_term:toggle()
end

function M.compilec_interactive()
	local filepath = vim.fn.expand("%:p")
	local dir = vim.fn.fnamemodify(filepath, ":h")
	local file = vim.fn.fnamemodify(filepath, ":t")
	local base = vim.fn.fnamemodify(filepath, ":t:r")

	local cmd = string.format(
		"cd %s && gcc %s -o %s && ./%s",
		vim.fn.shellescape(dir),
		vim.fn.shellescape(file),
		vim.fn.shellescape(base),
		vim.fn.shellescape(base)
	)

	local term = Terminal:new({
		cmd = cmd,
		direction = "horizontal",
		close_on_exit = false,
		on_open = function(t)
			startinsert(t)
			vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
				buffer = t.bufnr,
				once = true,
				callback = function()
					vim.schedule(function() t:shutdown() end)
				end,
			})
		end,
	})
	term:toggle()
end

return M
