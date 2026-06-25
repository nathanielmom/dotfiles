return {
    'ellisonleao/gruvbox.nvim',
    config = function()
        vim.cmd("colorscheme " .. vim.env.COLORSCHEME)
    end
}
