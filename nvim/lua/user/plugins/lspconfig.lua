return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'b0o/schemastore.nvim',
    { 'j-hui/fidget.nvim', tag = 'legacy' },
    -- { 'nvimtools/none-ls.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    -- 'jayp0521/mason-null-ls.nvim',
    -- 'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    -- LSP settings.
    --  This function gets run when an LS connects to a particular buffer.
    local on_attach = function(_, bufnr)

      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences') -- used for methods
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation') -- Used mainly for interfaces and traits
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<Leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(
        bufnr,
        'Format',
        function(_)
          vim.lsp.buf.format()
        end,
        { desc = 'Format current buffer with LSP' })
    end

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    local servers = {
      -- "clangd" ,
      -- "gopls",
      -- "pyright",
      -- "rust_analyzer",
      "ts_ls",
      "lua_ls",
      "tailwindcss",
      "jsonls",
      "emmet_language_server",
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Setup mason so it can manage external tooling
    require('mason').setup()

    -- Ensure the servers above are installed
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup({
      -- Disabling automatic_enable because mason-lspconfig causes nvim-lspconfig's on_attach function to not load at all
      automatic_enable = false, -- or create a exclude table
      ensure_installed = servers,
      -- if automatic_enable is true, the handlers will be used to configure the LSPs
      handlers = {
        -- ["lua_ls"] = function()
        --   require("lspconfig").lua_ls.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     settings = {
        --       Lua = {
        --         workspace = { checkThirdParty = false },
        --         telemetry = { enable = false },
        --         diagnostics = {
        --           globals = { 'vim' }
        --         }
        --       },
        --     },
        --   })
        -- end,
        -- ["json_ls"] = function()
        --   require("lspconfig").json_ls.setup({
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     settings = {
        --       json = {
        --         schemas = require('schemastore').json.schemas(),
        --       },
        --     },
        --   })
        -- end,
      }
    })

    require("lspconfig").tailwindcss.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    require("lspconfig").json_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
        },
      },
    })

    require("lspconfig").lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = {
            globals = { 'vim' }
          }
        },
      },
    })

    require('lspconfig').emmet_language_server.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'html', 'blade' },
    })

    -- PHP
    require('lspconfig').intelephense.setup({
      commands = {
        IntelephenseIndex = {
          function()
            vim.lsp.buf.execute_command({ command = 'intelephense.index.workspace' })
          end,
        },
      },
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- dartls
    require("lspconfig").dartls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        dart = {
          analysisExcludedFolders = {
            vim.fn.expand('$HOME/.pub-cache'),
            vim.fn.expand('$HOME/.flutterSDK'),
          }
        }
      },
      cmd = { "dart", 'language-server', '--protocol=lsp' },
    })

    -- Turn on lsp status information
    require('fidget').setup()

    -- require('lspconfig').emmet_language_server.setup({
    --   filetypes = { 'html', 'blade'},
    -- })

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = "Go to previous diagnostic"})
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = "Go to next diagnostic"})
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = "Open diagnostic float"})
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = "Set diagnostic loclist"})
  end
}
