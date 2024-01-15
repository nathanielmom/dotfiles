return {
  'github/copilot.vim',
  config = function()

    -- Copilot keymaps
    vim.g.copilot_no_tab_map = true
    vim.keymap.set("i", "<C-b>", "copilot#Accept('<CR>')", {noremap = true, silent = true, expr=true, replace_keycodes = false})
    vim.keymap.set('n', '<Leader>2', ':Copilot panel<CR>')

  end,
}

