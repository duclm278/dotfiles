-- Settings
vim.g.nord_borders = true
vim.g.nord_contrast = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false

-- Colorscheme
local colorscheme = "nord"

local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end

if vim.fn.has "termguicolors" then
    vim.opt.termguicolors = true
end
