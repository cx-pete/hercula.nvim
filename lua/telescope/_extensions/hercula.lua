local telescope = require("telescope")
local open = require("hercula").open

return telescope.register_extension({
	setup = require("lua/config").setup,
	exports = {
		hercula = open,
	},
})
