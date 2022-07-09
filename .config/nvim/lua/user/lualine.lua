local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    colored = false,
}

local diff = {
    "diff",
    colored = false,
    symbols = { added = "", modified = "", removed = "" }, -- Changes diff symbols
    cond = function() return vim.fn.winwidth(0) > 80 end,
}

local filetype = {
    "filetype",
    icons_enabled = false,
}

lualine.setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = ""},
        section_separators = { left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", diff, diagnostics },
        lualine_c = { "filename" },
        lualine_x = { "encoding", filetype },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
}
