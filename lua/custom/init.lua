if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h10"
  vim.api.nvim_set_keymap("n", "<C-c>", '"+y', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+pa', { noremap = true, silent = true })
  vim.api.nvim_set_option("clipboard", "unnamedplus")
end
