local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- Colorscheme
    { import = 'user.plugins.' .. vim.env.THEME },

    -- Add, change, and delete surrounding text.
    { 'tpope/vim-surround' },

    -- Useful commands like :Rename and :SudoWrite.
    { 'tpope/vim-eunuch' },

    -- File tree sidebar
    { import = 'user.plugins.neo-tree' },

    -- Add smooth scrolling to avoid jarring jumps
    { 'karb94/neoscroll.nvim', config = true },

    -- Automatically add closing brackets, quotes, etc.
    { 'windwp/nvim-autopairs', config = true },

    -- Git integration.
    { import = 'user.plugins.gitsigns' },

    -- Git commands.
    { 'tpope/vim-fugitive'},
    { 'tpope/vim-rhubarb'},

    --- Floating terminal.
    { import = 'user.plugins.floaterm' },

    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth' },

    -- Allow plugins to respond to native repeat command: `.`
    { 'tpope/vim-repeat' },

    -- Fuzzy finder
    { import = 'user.plugins.telescope' },

    -- LSP config
    { import = 'user.plugins.lspconfig'},

    -- Auto-completion
    { import = 'user.plugins.cmp'},

    -- Github Copilot
    { import = 'user.plugins.copilot'},

    -- Treesitter
    { import = 'user.plugins.treesitter'},

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Fancy status bar
    { import = 'user.plugins.lualine'},

    -- Run tests from nvim
    { import = 'user.plugins.vim-test'},

    -- PHP Refactoring Tools
    { import = 'user.plugins.phpactor' },

},{})
