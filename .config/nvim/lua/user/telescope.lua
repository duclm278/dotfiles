local status_ok, actions = pcall(require, "telescope.actions")
if not status_ok then
    return
end

local telescope = require "telescope"

telescope.setup {
    defaults = {

        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },

        mappings = {
            i = {
                ["<Up>"]   = actions.move_selection_previous,
                ["<Down>"] = actions.move_selection_next,
                ["<C-k>"]  = actions.move_selection_previous,
                ["<C-j>"]  = actions.move_selection_next,
            },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- The picker_config_key will be used if this builtin picker is called.
    },
    extensions = {
        -- Extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- Please take a look at the README of the extension to configured.
    },
}

-- Custom keymaps
local keymap = vim.keymap.set
local opts = { silent = true }
keymap("n", "<leader>fb", ":Telescope buffers<CR>"   , opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>"  , opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>" , opts)
