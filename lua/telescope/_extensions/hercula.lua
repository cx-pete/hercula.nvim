local telescope = require("telescope")
local open = require("hercula").open

return telescope.register_extension({
	exports = {
		hercula = open,
	},
})
