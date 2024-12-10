return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                    ",
			"                                    ",
			"                                    ",
			"                                    ",
			"    _   __                _         ",
			"   / | / /__  ____ _   __(_)___ ___ ",
			"  /  |/ / _ \\/ __ \\ | / / / __ `__ \\",
			" / /|  /  __/ /_/ / |/ / / / / / / /",
			"/_/ |_/\\___/\\____/|___/_/_/ /_/ /_/ ",
		}

		dashboard.section.buttons.val = {}

		alpha.setup(dashboard.opts)
	end,
}
