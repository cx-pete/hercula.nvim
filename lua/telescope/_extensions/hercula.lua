local telescope = require("telescope")
local open = require("hercula").open
local setup = require("hercula.config").setup

local has_telescope = pcall(require, "telescope")
if not has_telescope then
	vim.notify("Telescope is not installed", vim.log.levels.ERROR)
	return
end

local has_epub = pcall(require, "epub")
if not has_epub then
	vim.notify("epub.nvim is not installed", vim.log.levels.ERROR)
	return
end

return telescope.register_extension({
	setup = function(ext_config, config)
		if not ext_config then
			return setup(config)
		else
			return setup(ext_config)
		end
	end,
	exports = {
		hercula = open,
	},
})
