vim.cmd('set completeopt=menuone,noinsert,noselect')

local custom_attach = function(client, bfnr)
    print("LSP started.");
    require'completion'.on_attach(client)
    require'keybindings'.attach_lsp_keybindings(bfnr)
    vim.api.nvim_set_current_dir(client.config.root_dir)
end

require'lspsaga'.init_lsp_saga()

-- Scala
require'lspconfig'.metals.setup {on_attach = custom_attach}
-- Haskell
require'lspconfig'.hls.setup {on_attach = custom_attach}
-- Completion
require'lspconfig'.pyls.setup {on_attach = custom_attach}

-- Diagnostics
require"trouble".setup {}
