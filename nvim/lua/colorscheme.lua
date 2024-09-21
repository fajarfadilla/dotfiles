local M = {}

local telescope = require("telescope.builtin")
local action_state = require("telescope.actions.state")

function M.switch_colorscheme()
	telescope.colorscheme({
		enable_preview = true, -- set to true to enable preview
		attach_mappings = function(prompt_bufnr)
			local actions = require("telescope.actions")
			local set_colorscheme = function()
				local entry = action_state.get_selected_entry()
				if entry then
					local selected_colorscheme = entry.value
					vim.defer_fn(function()
						vim.cmd("colorscheme " .. selected_colorscheme)
					end, 0)
					M.write_colorscheme(selected_colorscheme)
					actions.close(prompt_bufnr)
				end
			end

			-- Map Enter key to select the colorscheme
			actions.select_default:replace(set_colorscheme)
			return true
		end,
	})
end

function M.write_colorscheme(colorscheme)
	local config_file = vim.fn.stdpath("config") .. "/init.lua"
	local lines = vim.fn.readfile(config_file)
	local new_lines = {}

	for _, line in ipairs(lines) do
		if line:find("vim.cmd%.colorscheme") then
			table.insert(new_lines, 'vim.cmd.colorscheme("' .. colorscheme .. '")')
		else
			table.insert(new_lines, line)
		end
	end

	vim.fn.writefile(new_lines, config_file)
end

return M
