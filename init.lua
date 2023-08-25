require("core")

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h11"
	vim.api.nvim_set_keymap("n", "<C-c>", '"+y', { noremap = true, silent = true })
	vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })
	vim.api.nvim_set_option("clipboard", "unnamedplus")
end
local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
	dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
	require("core.bootstrap").gen_chadrc_template()
	require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require("plugins")
