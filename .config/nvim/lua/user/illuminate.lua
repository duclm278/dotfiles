-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_ftblacklist = {"alpha", "NvimTree"}
vim.api.nvim_set_keymap("n", "<A-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>', { noremap = true, silent = true })
