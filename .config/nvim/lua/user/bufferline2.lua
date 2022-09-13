local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup {
    options = {
        close_command = "Bdelete! %d",       -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
    },
    highlights = {
        buffer_selected = {
            bold = true,
            italic = false,
        },
        diagnostic_selected = {
            bold = true,
            italic = false,
        },
        info_selected = {
            bold = true,
            italic = false,
        },
        info_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        warning_selected = {
            bold = true,
            italic = false,
        },
        warning_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        error_selected = {
            bold = true,
            italic = false,
        },
        error_diagnostic_selected = {
            bold = true,
            italic = false,
        },
        duplicate_selected = {
            italic = false,
        },
        duplicate_visible = {
            italic = false,
        },
        duplicate = {
            italic = false,
        },
        pick_selected = {
            bold = true,
            italic = false,
        },
        pick_visible = {
            bold = true,
            italic = false,
        },
        pick = {
            bold = true,
            italic = false,
        },
    },
}

-- Custom keymaps
local keymap = vim.keymap.set
local opts = { silent = true }
keymap("n", "<A-l>", ":BufferLineMoveNext<CR>" , opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<A-h>", ":BufferLineMovePrev<CR>" , opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
