return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  dependencies = {
    { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },
    --{ 'JoosepAlviste/nvim-ts-context-commentstring' },
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'comment',
      'css',
      'dart',
      'diff',
      'dockerfile',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'html',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'markdown',
      'php',
      'phpdoc',
      'python',
      'sql',
      'svelte',
      'typescript',
      'vim',
      'vue',
      'xml',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "yaml" }
    },
    context_commentstring = {
      enable = true,
    },
    rainbow = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
         -- You can use the capture groups defined in textobjects.scm
         ['aa'] = '@parameter.outer', -- vaa, daa, caa (e.g. daa will delete the whole parameter, including the comma)
         ['ia'] = '@parameter.inner', -- via, dia, cia (e.g. dia will delete only the parameter, leaving the comma)
         ['af'] = '@function.outer',  -- vaf, daf, caf
         ['if'] = '@function.inner',
         ['ac'] = '@class.outer',
         ['ic'] = '@class.inner',
        },
      },
    },
  },
  config = function (_, opts)
    require('nvim-treesitter.configs').setup(opts)

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {"src/parser.c"},
        branch = "main",
      },
      filetype = "blade"
    }
    vim.filetype.add({
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    })
    -- Run :TSEditQuery highlights blade, then copy contents of the above repo's queries/highlights.scm to ~/.config/nvim/queries/blade/highlights.scm
    -- Run :TSEditQuery injections blade, then copy contents of the above repo's queries/injections.scm to ~/.config/nvim/queries/blade/injections.scm
    -- Run :TSEditQuery folds blade, then copy contents of the above repo's queries/folds.scm to ~/.config/nvim/queries/blade/folds.scm
  end,
}
