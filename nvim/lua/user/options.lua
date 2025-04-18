-- [[ Setting options ]]
-- See `:help vim.opt`

-- Shot the title of the window as the filename
vim.opt.title = true

-- Make command line visible only when typing a command
-- Note that you will not see the command line when you are in normal mode, meaning things like macro recording status will not be visible
vim.opt.cmdheight = 0

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Remove the ~ from the end of the buffer
vim.opt.fillchars = { eob = " " }

-- Use 4 spaces for each tab
vim.opt.shiftwidth = 4

-- Be smart when using tabs ;)
vim.opt.tabstop = 4

-- Number of spaces tabs count for
vim.opt.softtabstop = 4

-- Set highlight on search
vim.opt.hlsearch = false

-- Don't wrap text
vim.opt.wrap = false

-- Make line numbers default
vim.opt.number = true

-- Make line numbers relative
vim.opt.relativenumber = true

-- Open vertical splits to the right and horizontal splits below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable mouse in all modes
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

-- Set colorscheme
vim.opt.termguicolors = true
vim.opt.background = "dark" -- or "light" for light mode

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

vim.opt.list = true -- enable this listchars below
vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- Enable spell check
vim.opt.spell = true

-- Keep cursor in the middle of the screen when scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Block cursor in all modes
vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor",
    "i:block-CursorInsert/lCursorInsert",
    "r-cr-o:hor20-CursorReplace/lCursorReplace",
}

-- Change block cursor color
vim.api.nvim_set_hl(0, "Cursor", { fg = "white", bg = "yellow" })
vim.api.nvim_set_hl(0, "CursorInsert", { fg = "white", bg = "magenta" })
vim.api.nvim_set_hl(0, "CursorReplace", { fg = "white", bg = "magenta" })
