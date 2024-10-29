local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'tsserver',
    'jsonls',
    'vimls',
    'yamlls',
    'html',
    'cssls',
    'graphql',
    'sqlls',
    'cssls',
    'dotls',
    'terraformls'
  },
  handlers = {
    lsp_zero.default_setup,
  },
})
