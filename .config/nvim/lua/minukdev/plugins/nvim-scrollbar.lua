return {
	"petertriho/nvim-scrollbar",
	version = "*",
	config = function()
		local scrollbar = require("scrollbar")
		scrollbar.setup()
	end,
}
