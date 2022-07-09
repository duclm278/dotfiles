-- vim.g.Illuminate_delay = 0
-- vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree" }

-- Custom keymaps
local keymap = vim.keymap.set
keymap("n", "<A-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<CR>')
keymap("n", "<A-p>", '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>')
