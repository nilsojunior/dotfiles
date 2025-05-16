local M = {}

local hex_pattern = "#%x%x%x%x%x%x"

local css_colours = {
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

local function find_hex_colors()
	local hex_colors = {}
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for linenr, line in ipairs(lines) do
		for hex in line:gmatch("#%x%x%x%x%x%x") do
			table.insert(hex_colors, { line = linenr, color = hex })
		end
	end

	return hex_colors
end

local function add_icon_to_colors(hex_colors)
	local icon = ""
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, entry in ipairs(hex_colors) do
		local line = lines[entry.line]

		if not line:match(icon) then
			lines[entry.line] = line:gsub(entry.color, icon .. " " .. entry.color)
		end
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
		callback = function(args)
			local hex_colors = find_hex_colors()
			add_icon_to_colors(hex_colors)
		end,
	})
end

return M
