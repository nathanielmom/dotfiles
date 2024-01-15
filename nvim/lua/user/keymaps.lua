-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', ';;', '<End>;', { silent = true })
vim.keymap.set('i', ',,', '<End>,', { silent = true })
vim.keymap.set('n', ';;', 'A;<Esc>', { silent = true })
vim.keymap.set('n', ',,', 'A,<Esc>', { silent = true })
vim.keymap.set('n', '<CR>', 'o<Esc>', { silent = true })
vim.keymap.set('i', 'jj', '<Esc>', { silent = true })
vim.keymap.set('n', '<Leader>w', ':w!<cr>', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })

-- Sort PHP 'Use' statements by length
vim.keymap.set('v', '<Leader>sl', [[! awk '{ print length(), $0 | "sort -n" }' | cut -d' ' -f 2-<cr>]],
  { desc = '[S]ort lines according to [l]ength' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('v', 'p', '"_dP', { silent = true })
