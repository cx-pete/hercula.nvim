-- NOTE: Hercula.nvim is a telescope EPUB finder - EpubOpen requires CrystalDime/epub.nvim
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local scan = require("plenary.scandir")
--
local M = {}
M.setup = function(opts)
	opts = opts or {}
	local defaults = {
		-- TODO: Add mappings
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
	M.options = vim.tbl_deep_extend("force", defaults, opts)
end

local function find_books_extended()
	local config = M.options
	local dirs = config.dirs
	local result_list = {}
	for i, dir in pairs(dirs) do
		local results = scan.scan_dir(dir, {
			hidden = config.scan.hidden,
			depth = config.scan.depth,
			search_pattern = config.scan.search_pattern,
		})
		for j, path in pairs(results) do
			local split = {}

			table.insert(split, path)
			table.insert(split, string.match(string.sub(path, 1, (string.len(path) - 5)), ".+/([^/]+)$"))
			table.insert(result_list, split)
		end
	end
	return result_list
end

M.open = function(opts)
	-- M.setup(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Finder",
			finder = finders.new_table({
				results = find_books_extended(),
				entry_maker = function(entry)
					return {
						value = entry,
						path = entry[1],
						display = entry[2],
						ordinal = entry[2],
					}
				end,
			}),
			sorter = conf.file_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local entry = action_state.get_selected_entry()
					local path = entry["path"]
					-- window config options
					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					local window_w = screen_w * 0.5
					if window_w < 60 then
						window_w = screen_w * 0.8
					end
					local window_h = screen_h * 0.9
					local window_w_int = math.floor(window_w)
					local window_h_int = math.floor(window_h)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
					print(window_w)
					vim.api.nvim_open_win(0, true, {
						relative = "editor",
						row = center_y,
						col = center_x,
						width = window_w_int,
						height = window_h_int,
						style = "minimal",
						border = "rounded",
						anchor = "NW",
						title = " hercula.nvim ",
						title_pos = "center",
					})
					require("epub").open_epub(path)
				end)
				return true
			end,
		})
		:find()
end

-- M.open({ scan = { search_pattern = ".epub" } })
return M
