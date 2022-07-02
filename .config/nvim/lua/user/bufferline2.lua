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
            gui = "bold"
        },
        diagnostic_selected = {
            gui = "bold"
        },
        info_selected = {
            gui = "bold"
        },
        info_diagnostic_selected = {
            gui = "bold"
        },
        warning_selected = {
            gui = "bold"
        },
        warning_diagnostic_selected = {
            gui = "bold"
        },
        error_selected = {
            gui = "bold"
        },
        error_diagnostic_selected = {
            gui = "bold"
        },
        duplicate_selected = {
            gui = "none",
        },
        duplicate_visible = {
            gui = "none",
        },
        duplicate = {
            gui = "none",
        },
        pick_selected = {
            gui = "bold"
        },
        pick_visible = {
            gui = "bold"
        },
        pick = {
            gui = "bold"
        },
    }
}
