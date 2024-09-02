local telescope = require("telescope")
local open = require("hercula").open
local setup = require("config").setup
return telescope.register_extension({
	setup = setup,
	exports = {
		hercula = open,
	},
})
