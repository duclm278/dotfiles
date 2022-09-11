-- Shorten stuff
local keymap = vim.keymap.set
local opts = { silent = true }

-- Set leader key
vim.g.mapleader = " "
keymap("", "<Space>", "<Nop>", opts)

-- I hate escape more than anything else
keymap("i", "jk", "<Esc>", opts)

-- Move up and down in insert-mode completion
keymap("i", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true })
keymap("i", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true })

-- Move up and down in cmdline-mode completion
keymap("c", "<Up>"  , 'wildmenumode() ? "\\<C-p>" : "\\<Up>"'  , { expr = true })
keymap("c", "<Down>", 'wildmenumode() ? "\\<C-n>" : "\\<Down>"', { expr = true })
keymap("c", "<C-k>" , 'wildmenumode() ? "\\<C-p>" : "\\<C-k>"' , { expr = true })
keymap("c", "<C-j>" , 'wildmenumode() ? "\\<C-n>" : "\\<C-j>"' , { expr = true })

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected line or block of text
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)

-- Navigate buffers
keymap("n", "<Tab>"  , ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Left>" , ":vertical resize -2<CR>", opts)
keymap("n", "<C-Down>" , ":resize -2<CR>", opts)
keymap("n", "<C-Up>"   , ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- No highlight
keymap("n", "<leader>n", ":nohlsearch<CR>", opts)

-- Great tricks
keymap("n", "<leader>d", '"_d' , opts)
keymap("n", "<leader>y", '"+y' , opts)
keymap("v", "<leader>d", '"_d' , opts)
keymap("v", "<leader>p", '"_dP', opts)
keymap("v", "<leader>y", '"+y' , opts)
