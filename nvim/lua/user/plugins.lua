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
    -- { import = 'user.plugins.treesitter'},

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Fancy status bar
    { import = 'user.plugins.lualine'},

    -- Run tests from nvim
    { import = 'user.plugins.vim-test'},

    -- PHP Refactoring Tools
    { import = 'user.plugins.phpactor' },

},{})

vim.opt.packpath:prepend(vim.fn.stdpath('data') .. '/site')

-- ~/.config/nvim/lua/plugins/treesitter.lua
-- nvim-treesitter (main branch) with vim.pack on Neovim 0.12

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

-- ── Parsers ────────────────────────────────────────────────────────────
-- Replaces `ensure_installed`. install() is async and idempotent — safe
-- to call on every startup; already-installed parsers are skipped.
require("nvim-treesitter").install({
  "bash", "blade", "comment", "css", "dart", "diff", "dockerfile",
  "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
  "go", "html", "javascript", "json", "lua",
  "markdown", "markdown_inline",  -- markdown needs both
  "php", "phpdoc", "python", "sql", "svelte", "typescript", "tsx",
  "vim", "vimdoc", "xml", "yaml",
})

-- Re-run :TSUpdate after vim.pack pulls new commits.
vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Update nvim-treesitter parsers after pack update",
  callback = function(ev)
    local d = ev.data
    if d and d.spec and d.spec.name == "nvim-treesitter" and d.kind == "update" then
      vim.schedule(function()
        require("nvim-treesitter").update()
      end)
    end
  end,
})

-- ── Highlight + indent + folds (per-buffer) ───────────────────────────
-- Replaces highlight={enable=true} / indent={enable=true,disable={"yaml"}}.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf = args.buf
    local ft  = vim.bo[buf].filetype
    if not pcall(vim.treesitter.start, buf) then return end

    if ft ~= "yaml" then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    -- Folds are still defined, just opened — so zc to close one, zM to close all, zR to reopen all still work whenever you want them.
  end,
})

-- ── Textobjects (new API) ─────────────────────────────────────────────
require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
})

local function sel(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end
local function swap_next(q) return function() require("nvim-treesitter-textobjects.swap").swap_next(q)     end end
local function swap_prev(q) return function() require("nvim-treesitter-textobjects.swap").swap_previous(q) end end

vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer")) -- vaa, daa, caa (e.g. daa will delete the whole parameter, including the comma)
vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner")) -- via, dia, cia (e.g. dia will delete only the parameter, leaving the comma)
vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"))  -- vaf, daf, caf
vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"))
vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"))
vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"))

vim.keymap.set("n", "<leader>a", swap_next("@parameter.inner"))
vim.keymap.set("n", "<leader>A", swap_prev("@parameter.inner"))

-- ── Blade filetype ────────────────────────────────────────────────────
vim.filetype.add({
  pattern = { [".*%.blade%.php"] = "blade" },
})
-- See note below about installing the blade parser itself.
