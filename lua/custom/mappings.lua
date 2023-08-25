---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>sl"] = { "<cmd> Telescope persisted <CR>" },
    ["<leader>ss"] = { "<cmd> SessionSave <CR>" },
    ["<leader>sd"] = { "<cmd> SessionDelete <CR>" },
    ["<leader><leader>"] = { "<cmd> noh <CR>" },
  },
}

return M
