-- Colorscheme
local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("Colorscheme " .. colorscheme .. " not found!")
    return
end

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end
