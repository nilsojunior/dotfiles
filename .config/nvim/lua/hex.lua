local M = {}

local css_colors = {
	aliceblue = "#f0f8ff",
	antiquewhite = "#faebd7",
	aqua = "#00ffff",
	aquamarine = "#7fffd4",
	azure = "#f0ffff",
	beige = "#f5f5dc",
	bisque = "#ffe4c4",
	black = "#000000",
	blanchedalmond = "#ffebcd",
	blue = "#0000ff",
	blueviolet = "#8a2be2",
	brown = "#a52a2a",
	burlywood = "#deb887",
	cadetblue = "#5f9ea0",
	chartreuse = "#7fff00",
	chocolate = "#d2691e",
	coral = "#ff7f50",
	cornflowerblue = "#6495ed",
	cornsilk = "#fff8dc",
	crimson = "#dc143c",
	cyan = "#00ffff",
	darkblue = "#00008b",
	darkcyan = "#008b8b",
	darkgoldenrod = "#b8860b",
	darkgray = "#a9a9a9",
	darkgreen = "#006400",
	darkgrey = "#a9a9a9",
	darkkhaki = "#bdb76b",
	darkmagenta = "#8b008b",
	darkolivegreen = "#556b2f",
	darkorange = "#ff8c00",
	darkorchid = "#9932cc",
	darkred = "#8b0000",
	darksalmon = "#e9967a",
	darkseagreen = "#8fbc8f",
	darkslateblue = "#483d8b",
	darkslategray = "#2f4f4f",
	darkslategrey = "#2f4f4f",
	darkturquoise = "#00ced1",
	darkviolet = "#9400d3",
	deeppink = "#ff1493",
	deepskyblue = "#00bfff",
	dimgray = "#696969",
	dimgrey = "#696969",
	dodgerblue = "#1e90ff",
	firebrick = "#b22222",
	floralwhite = "#fffaf0",
	forestgreen = "#228b22",
	fuchsia = "#ff00ff",
	gainsboro = "#dcdcdc",
	ghostwhite = "#f8f8ff",
	gold = "#ffd700",
	goldenrod = "#daa520",
	gray = "#808080",
	green = "#008000",
	greenyellow = "#adff2f",
	grey = "#808080",
	honeydew = "#f0fff0",
	hotpink = "#ff69b4",
	indianred = "#cd5c5c",
	indigo = "#4b0082",
	ivory = "#fffff0",
	khaki = "#f0e68c",
	lavender = "#e6e6fa",
	lavenderblush = "#fff0f5",
	lawngreen = "#7cfc00",
	lemonchiffon = "#fffacd",
	lightblue = "#add8e6",
	lightcoral = "#f08080",
	lightcyan = "#e0ffff",
	lightgoldenrodyellow = "#fafad2",
	lightgray = "#d3d3d3",
	lightgreen = "#90ee90",
	lightgrey = "#d3d3d3",
	lightpink = "#ffb6c1",
	lightsalmon = "#ffa07a",
	lightseagreen = "#20b2aa",
	lightskyblue = "#87cefa",
	lightslategray = "#778899",
	lightslategrey = "#778899",
	lightsteelblue = "#b0c4de",
	lightyellow = "#ffffe0",
	lime = "#00ff00",
	limegreen = "#32cd32",
	linen = "#faf0e6",
	magenta = "#ff00ff",
	maroon = "#800000",
	mediumaquamarine = "#66cdaa",
	mediumblue = "#0000cd",
	mediumorchid = "#ba55d3",
	mediumpurple = "#9370db",
	mediumseagreen = "#3cb371",
	mediumslateblue = "#7b68ee",
	mediumspringgreen = "#00fa9a",
	mediumturquoise = "#48d1cc",
	mediumvioletred = "#c71585",
	midnightblue = "#191970",
	mintcream = "#f5fffa",
	mistyrose = "#ffe4e1",
	moccasin = "#ffe4b5",
	navajowhite = "#ffdead",
	navy = "#000080",
	oldlace = "#fdf5e6",
	olive = "#808000",
	olivedrab = "#6b8e23",
	orange = "#ffa500",
	orangered = "#ff4500",
	orchid = "#da70d6",
	palegoldenrod = "#eee8aa",
	palegreen = "#98fb98",
	paleturquoise = "#afeeee",
	palevioletred = "#db7093",
	papayawhip = "#ffefd5",
	peachpuff = "#ffdab9",
	peru = "#cd853f",
	pink = "#ffc0cb",
	plum = "#dda0dd",
	powderblue = "#b0e0e6",
	purple = "#800080",
	rebeccapurple = "#663399",
	red = "#ff0000",
	rosybrown = "#bc8f8f",
	royalblue = "#4169e1",
	saddlebrown = "#8b4513",
	salmon = "#fa8072",
	sandybrown = "#f4a460",
	seagreen = "#2e8b57",
	seashell = "#fff5ee",
	sienna = "#a0522d",
	silver = "#c0c0c0",
	skyblue = "#87ceeb",
	slateblue = "#6a5acd",
	slategray = "#708090",
	slategrey = "#708090",
	snow = "#fffafa",
	springgreen = "#00ff7f",
	steelblue = "#4682b4",
	tan = "#d2b48c",
	teal = "#008080",
	thistle = "#d8bfd8",
	tomato = "#ff6347",
	turquoise = "#40e0d0",
	violet = "#ee82ee",
	wheat = "#f5deb3",
	white = "#ffffff",
	whitesmoke = "#f5f5f5",
	yellow = "#ffff00",
	yellowgreen = "#9acd32",
}

local ns_id = vim.api.nvim_create_namespace("hexcolor_preview")

local function clamp(val, min, max)
	return math.max(min, math.min(max, val))
end

local function hsl_to_rgb(h, s, l)
	h = h % 360
	s = clamp(s / 100, 0, 1)
	l = clamp(l / 100, 0, 1)

	local c = (1 - math.abs(2 * l - 1)) * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = l - c / 2

	local r1, g1, b1
	if h < 60 then
		r1, g1, b1 = c, x, 0
	elseif h < 120 then
		r1, g1, b1 = x, c, 0
	elseif h < 180 then
		r1, g1, b1 = 0, c, x
	elseif h < 240 then
		r1, g1, b1 = 0, x, c
	elseif h < 300 then
		r1, g1, b1 = x, 0, c
	else
		r1, g1, b1 = c, 0, x
	end

	local r = math.floor((r1 + m) * 255 + 0.5)
	local g = math.floor((g1 + m) * 255 + 0.5)
	local b = math.floor((b1 + m) * 255 + 0.5)

	return r, g, b
end

local function rgba_to_hex(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

local function parse_rgb(str)
	local r, g, b = str:match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
	if r and g and b then
		return tonumber(r), tonumber(g), tonumber(b)
	end
end

local function parse_rgba(str)
	local r, g, b, a = str:match("rgba%((%d+),%s*(%d+),%s*(%d+),%s*([%d%.]+)%)")
	if r and g and b then
		return tonumber(r), tonumber(g), tonumber(b), tonumber(a)
	end
end

local function parse_hsl(str)
	local h, s, l = str:match("hsl%(([%d%.]+),%s*([%d%.]+)%%,%s*([%d%.]+)%%%)")
	if h and s and l then
		return tonumber(h), tonumber(s), tonumber(l)
	end
end

local function parse_hsla(str)
	local h, s, l, a = str:match("hsla%(([%d%.]+),%s*([%d%.]+)%%,%s*([%d%.]+)%%,%s*([%d%.]+)%)")
	if h and s and l and a then
		return tonumber(h), tonumber(s), tonumber(l), tonumber(a)
	end
end

local function update_color_previews(bufnr)
	vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for i, line in ipairs(lines) do
		local search_patterns = {
			{
				pattern = "#%x%x%x%x%x%x",
				converter = function(color)
					return color
				end,
			},
			{
				pattern = "rgb%(%d+,%s*%d+,%s*%d+%)",
				converter = function(color)
					local r, g, b = parse_rgb(color)
					if r and g and b then
						return rgba_to_hex(r, g, b)
					end
				end,
			},
			{
				pattern = "rgba%(%d+,%s*%d+,%s*%d+,%s*[%d%.]+%)",
				converter = function(color)
					local r, g, b = parse_rgba(color)
					if r and g and b then
						return rgba_to_hex(r, g, b)
					end
				end,
			},
			{
				pattern = "hsl%(([%d%.]+),%s*([%d%.]+)%%,%s*([%d%.]+)%%%)",
				converter = function(color)
					local h, s, l = parse_hsl(color)
					if h and s and l then
						local r, g, b = hsl_to_rgb(h, s, l)
						return rgba_to_hex(r, g, b)
					end
				end,
			},
			{
				pattern = "hsla%(([%d%.]+),%s*([%d%.]+)%%,%s*([%d%.]+)%%,%s*([%d%.]+)%)",
				converter = function(color)
					local h, s, l = parse_hsla(color)
					if h and s and l then
						local r, g, b = hsl_to_rgb(h, s, l)
						return rgba_to_hex(r, g, b)
					end
				end,
			},
			{
				pattern = "%f[%a]%w+%f[^%w]",
				converter = function(word)
					local color = word:lower()
					if css_colors[color] then
						return css_colors[color]
					end
				end,
			},
		}

		for _, entry in ipairs(search_patterns) do
			local start = 1
			while true do
				local col_start, col_end = line:find(entry.pattern, start)
				if not col_start then
					break
				end

				local color_str = line:sub(col_start, col_end)
				local hex = entry.converter(color_str)
				if hex then
					local hl_group = "HexColor_" .. hex:sub(2)
					if vim.fn.hlID(hl_group) == 0 then
						vim.api.nvim_set_hl(0, hl_group, { fg = hex })
					end

					vim.api.nvim_buf_set_extmark(bufnr, ns_id, i - 1, col_start - 1, {
						virt_text = { { " ", hl_group } },
						virt_text_pos = "inline",
						hl_mode = "combine",
					})
				end
				start = col_end + 1
			end
		end
	end
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
		callback = function(args)
			update_color_previews(args.buf)
		end,
	})
end

return M
