local M = {}
local ns = vim.api.nvim_create_namespace("csscolor")

local named_colors = {
	red = "#ff0000",
	blue = "#0000ff",
	green = "#008000",
	yellow = "#ffff00",
	black = "#000000",
	white = "#ffffff",
	gray = "#808080",
	orange = "#ffa500",
	purple = "#800080",
	pink = "#ffc0cb",
	brown = "#a52a2a",
	cyan = "#00ffff",
	magenta = "#ff00ff",
}

-- Create highlight group for color if it doesn't exist
local function define_color_highlight(color, hex)
	local hl = "CssColor_" .. color
	if vim.fn.hlexists(hl) == 0 then
		vim.api.nvim_set_hl(0, hl, { fg = hex })
	end
	return hl
end

-- Check if word appears as a value (e.g., after `:` and before `;`)
local function find_color_values(line)
	local matches = {}
	for prop, val in line:gmatch("([%w%-]+)%s*:%s*([%w%-]+)") do
		if named_colors[val] then
			local start_col, end_col = line:find(val)
			if start_col and end_col then
				table.insert(matches, { color = val, s = start_col - 1, e = end_col })
			end
		end
	end
	return matches
end

function M.highlight_colors(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

	for linenr = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
		local line = vim.api.nvim_buf_get_lines(bufnr, linenr, linenr + 1, false)[1]
		for _, match in ipairs(find_color_values(line)) do
			local hl = define_color_highlight(match.color, named_colors[match.color])
			vim.api.nvim_buf_add_highlight(bufnr, ns, hl, linenr, match.s, match.e)
		end
	end
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
		pattern = "*.css",
		callback = function(args)
			M.highlight_colors(args.buf)
		end,
	})
end

return M
