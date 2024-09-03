-- NOTE: Hercula.nvim is a telescope EPUB finder - EpubOpen requires CrystalDime/epub.nvim

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local make_entry = require("telescope.make_entry")
local scan = require("plenary.scandir")
--
local function find_books_extended(opts)
	local config = require("hercula.config").options
	opts = opts or {}
	local dirs = config.dirs
	local result_list = {}
	for k, v in pairs(dirs) do
		local results = scan.scan_dir(v, {
			hidden = config.scan.hidden,
			depth = config.scan.depth,
			search_pattern = config.scan.search_pattern,
		})
		for k2, v2 in pairs(results) do
			table.insert(result_list, v2)
		end
	end
	return result_list
end

local M = {}
M.open = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Finder",
			finder = finders.new_table({
				results = find_books_extended(opts),
				entry_maker = make_entry.gen_from_file(opts),
				-- TODO: Entry maker should use extracted EPUB data for better search
			}),
			sorter = conf.file_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local entry = action_state.get_selected_entry()
					local path = entry["path"]
					print(path)

					vim.api.nvim_open_win(0, true, {
						relative = "win",
						row = 0,
						col = 10,
						width = 66,
						height = 35,
						style = "minimal",
						border = "rounded",
						anchor = "NW",
						title = " hercula.nvim ",
						title_pos = "center",
					})
					--vim.cmd.set("guicursor=")
					--vim.cmd.set("linebreak")
					require("epub").open_epub(path)
				end)
				return true
			end,
		})
		:find()
end
--M.open()
return M
