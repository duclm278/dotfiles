local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
    return
end

illuminate.configure {
    providers = {
        "lsp",
        "treesitter",
        "regex",
    },
    delay = 100,
    filetype_overrides = {},
    filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "toggleterm",
        "TelescopePrompt",
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
}
