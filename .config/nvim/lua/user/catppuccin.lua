local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
    return
end

-- Settings
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
catppuccin.setup {
    styles = {
        comments = { "italic" },
        conditionals = { "bold" },
        loops = { "bold" },
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = { "bold" },
    },
}

-- Colorscheme
local colorscheme = "catppuccin"

local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end

if vim.fn.has "termguicolors" then
    vim.opt.termguicolors = true
end
