-- Settings
vim.g.nord_underline_option = "none"
vim.g.nord_italic = false
vim.g.nord_italic_comments = false
vim.g.nord_minimal_mode = false
vim.g.nord_alternate_backgrounds = false

-- Colorscheme
local colorscheme = "nordic"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end
