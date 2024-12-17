local colors = {
	highlight_fg = "#cdd6f4",
	highlight_bg = "#313244",
}

local set_hl = vim.api.nvim_set_hl

set_hl(0, "TelescopeSelection", {
	fg = colors.highlight_fg,
	bg = colors.highlight_bg,
})

set_hl(0, "NvimTreeFolderArrowOpen", {
	fg = colors.highlight_fg,
})
