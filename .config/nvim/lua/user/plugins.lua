local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer.nvim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Reload neovim after saving plugins.lua
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"          -- Have packer manage itself
    use "nvim-lua/popup.nvim"             -- An implementation of the popup API from vim in neovim
    use "nvim-lua/plenary.nvim"           -- Useful lua functions used by lots of plugins
    use "windwp/nvim-autopairs"
    use "numToStr/Comment.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    use "lukas-reineke/indent-blankline.nvim"

    -- Colorschemes
    use { "shaunsingh/nord.nvim" }
    use { "andersevenrud/nordic.nvim" }
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Completions
    use "hrsh7th/nvim-cmp"                -- Core plugin
    use "hrsh7th/cmp-buffer"              -- Buffer completions
    use "hrsh7th/cmp-path"                -- Path completions
    use "hrsh7th/cmp-cmdline"             -- Cmdline completions
    use "saadparwaiz1/cmp_luasnip"        -- Snippet completions
    use "hrsh7th/cmp-nvim-lsp"            -- LSP completions
    use "hrsh7th/cmp-nvim-lua"            -- Better Nvim completions

    -- Snippets
    use "L3MON4D3/LuaSnip"                -- Snippet engine
    use "rafamadriz/friendly-snippets"    -- A bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig"           -- Enable LSP
    use "williamboman/nvim-lsp-installer" -- Simple to use LSP installer
    use "RRethy/vim-illuminate"
    use "jose-elias-alvarez/null-ls.nvim"

    -- SchemaStore
    use "b0o/schemastore.nvim"

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    use { "JoosepAlviste/nvim-ts-context-commentstring" }

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
