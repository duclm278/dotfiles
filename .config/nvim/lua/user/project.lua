local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    return
end

project.setup {
    -- NOTE: LSP detection will get annoying with multiple langs in one project.
    -- detection_methods = { "lsp", "pattern" },
    detection_methods = { "pattern" },

    -- Patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
}

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
    return
end

telescope.load_extension "projects"
