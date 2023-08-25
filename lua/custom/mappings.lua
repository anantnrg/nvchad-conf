---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<leader>sl"] = {
			function()
				require("resession").load()
			end,
		},
		["<leader>ss"] = {
			function()
				require("resession").save()
			end,
		},
		["<leader>sd"] = {
			function()
				require("resession").delete()
			end,
		},
	},
}

return M
