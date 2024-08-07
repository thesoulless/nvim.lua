local lsp = require('lsp-zero')
--[[
require('lspconfig').lua_ls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').golangci_lint_ls.setup({})
require('lspconfig').gopls.setup({})
--]]
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').pyright.setup {}

require('lspconfig').ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}

require('lspconfig').gopls.setup({
    cmd = { "gopls", "serve" },
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
    on_attach = function(client, bufnr)
        require "lsp_signature".on_attach(signature_setup, bufnr) -- Note: add in lsp client on-attach
    end,
})

-- require('lspconfig').eslint.setup({
--     --- ...
--     on_attach = function(client, bufnr)
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             buffer = bufnr,
--             command = "EslintFixAll",
--         })
--     end,
-- })

require 'lspconfig'.biome.setup {
    single_file_support = true,
}

require('lspconfig').emmet_language_server.setup({
    filetypes = { "eruby", "html",
        "less", "sass", "scss", "svelte", "pug", "vue" },
    -- "javascript", "javascriptreact", "typescriptreact",
    -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
    -- **Note:** only the options listed in the table are supported.
    init_options = {
        --- @type string[]
        excludeLanguages = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

lsp.set_preferences({
    sign_icons = {}
})

cmp.setup({
    preselect = true,
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = "path" },
        { name = "path" },
        { name = "calc" },
        { name = "emoji" } -- load for writing only
    }, {
        { name = 'buffer' },
    }),
    snippet = {
        -- expand = function(args)
        --     vim.fn["vsnip#anonymous"](args.body)
        -- end,
    },
    window = {
        completion = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm(cmp_select),
        ['<Tab>'] = nil,
    })
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'rust_analyzer',
        'gopls',
        -- 'golangci_lint_ls',
        -- 'emmet_language_server',
        'eslint',
        'lua_ls',
        'pyright'
    },
    handlers = {
        lsp_zero.default_setup,
    },
})
