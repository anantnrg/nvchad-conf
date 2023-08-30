---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>sl"] = { "<cmd> Telescope persisted <CR>" },
    ["<leader>ss"] = { "<cmd> SessionSave <CR>" },
    ["<leader>sd"] = { "<cmd> SessionDelete <CR>" },
    ["<leader><leader>"] = { "<cmd> noh <CR>" },
    ["j"] = { "gj" },
    ["k"] = { "gk" },
  },
  i = {
    ["<C-j>"] = { "<C-o>gj" },
    ["<C-k>"] = { "<C-o>gk" },
    ["<C-h>"] = { "<Left>" },
    ["<C-l>"] = { "<Right>" },
  },
}

return M
