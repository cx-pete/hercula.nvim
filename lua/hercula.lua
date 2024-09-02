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

local M = {}
require("telescope").load_extension("hercula")

--M.actions = require("hercula.actions")
M.open = require("hercula").open
M.setup = function(opts)
	require("lua/config").setup(opts)
end
--M.utils = require("hercula.utils")

return M
