--local actions = require("hercula.actions")
local M = {}

local defaults = {
	mappings = {
		i = {
			--["<C-m>"] = { action = actions.mark },
		},
	},
	titles = {
		results = "Results", -- title of the results buffer in telescope
	},
	results = {
		fields = {
			"title",
			"author",
			"term_icon",
		},
		separator = " ", -- the character that will be used to separate each field provided in results.fields
		term_icon = "", -- the icon that will be used for the term_icon in results.fields
	},
	search = {
		field = "title", -- the field that telescope fuzzy search will use
	},
	sort = {
		field = "title", -- the field that will be used for sorting in the telesocpe results
		ascending = true, -- whether or not the field provided above will be sorted in ascending or descending order
	},
}

M.options = {}
function M.setup(opts)
	opts = opts or {}
	M.options = vim.tbl_deep_extend("force", defaults, opts)
end
M.setup()
return M
