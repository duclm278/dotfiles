return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.schedule(function()
          if vim.o.background == "light" then
            vim.cmd("colorscheme catppuccin-latte")
          else
            vim.cmd("colorscheme catppuccin-mocha")
          end
        end)
      end,
    },
  },
}
