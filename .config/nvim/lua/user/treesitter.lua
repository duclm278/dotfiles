local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { "" },

    autopairs = {
        enable = true,
    },

    highlight = {
        -- Setting to `false` will disable the whole extension.
        enable = true,

        -- List of language that will be disabled
        disable = { "" },

        additional_vim_regex_highlighting = true,
    },

    indent = { enable = true, disable = { "python" } },

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
}
