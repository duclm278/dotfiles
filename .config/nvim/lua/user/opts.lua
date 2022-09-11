local options = {
    number = true,
    relativenumber = true,
    hidden = true,
    ignorecase = true,
    smartcase = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    cmdheight = 2,
    updatetime = 250,
    signcolumn = "yes",
    wrap = false,
    pumheight = 12,
    mouse = "a",
    splitbelow = true,
    splitright = true,
    cursorline = true,
    -- clipboard = "unnamedplus",
    scrolloff = 8,
    swapfile = false,
    -- textwidth = 80,
    -- colorcolumn = "+1",
    completeopt = { "menuone", "noselect" },
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Stop new line continuation of comments
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
