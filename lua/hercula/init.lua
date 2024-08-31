-- NOTE: Hercula.nvim is a telescope EPUB finder - EpubOpen requires CrystalDime/epub.nvim
--
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local make_entry = require("telescope.make_entry")
local scan = require("plenary.scandir")
--
--
local function find_books(opts)
	opts = opts or {}
	local result_list = scan.scan_dir(vim.fn.getcwd(), {
		hidden = false,
		depth = 2,
		search_pattern = ".epub",
	})
	return result_list
end

local M = {}
M.open = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "hercula",
			finder = finders.new_table({
				results = find_books(opts),
				entry_maker = make_entry.gen_from_file(opts),
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
						title = " bookwarp ",
						--title_pos = "center",
					})
					vim.cmd.set("guicursor=")
					--vim.cmd.set("linebreak")
					vim.cmd.EpubOpen(path)
				end)
				return true
			end,
		})
		:find()
end
return M
