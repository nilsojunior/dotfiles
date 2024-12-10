return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup({
			opLeader = {
				opLeader = {
					line = "gc",
					block = "gb",
				},
			},
		})
	end,
}
