--local actions = require("hercula.actions")
local M = {}

local defaults = {
	mappings = {
		i = {
			--["<C-m>"] = { action = actions.mark },
		},
	},
	dirs = {
		vim.env.HOME,
	},
	scan = {
		hidden = false,
		depth = 5,
		search_pattern = ".epub",
	},
}

M.options = {}

M.setup = function(opts)
	opts = opts or {}
	M.options = vim.tbl_deep_extend("force", defaults, opts)
end

return M
