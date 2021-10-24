require'lspsaga'.init_lsp_saga()

----------------------------------------------------------------------
-- Completion
----------------------------------------------------------------------

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' }
  })
})

----------------------------------------------------------------------
-- lspconfig
----------------------------------------------------------------------

local custom_attach = function(client, bfnr)
    print("LSP started.");
    require'keybindings'.attach_lsp_keybindings(bfnr);
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local serverOptions = {
  on_attach = custom_attach,
  init_options = { usePlaceholders = true },
  capabilities = capabilities
}
local lspconfig = require "lspconfig"

-- Haskell
lspconfig.hls.setup(serverOptions)
-- Nix
lspconfig.rnix.setup(serverOptions)
-- Purescript
lspconfig.purescriptls.setup(serverOptions)
-- Rescript
lspconfig.rescriptls.setup{
  cmd = { 'node', vim.env.HOME .. '/.nix-profile/rescriptls/extension/server/out/server.js', '--stdio'};
  root_dir = lspconfig.util.root_pattern("bsconfig.json", ".git");
}
-- HTML
require'lspconfig'.html.setup{}
-- CSS
lspconfig.cssls.setup{
  cmd = {vim.env.HOME .. '/.nix-profile/bin/vscode-css-language-server', '--stdio'}
}
-- JSON
lspconfig.jsonls.setup{
  cmd = {vim.env.HOME .. '/.nix-profile/bin/vscode-json-language-server', '--stdio'}
}
-- Javascript/Typescript
require'lspconfig'.tsserver.setup{
  cmd = {vim.env.HOME .. '/.nix-profile/bin/typescript-language-server', '--stdio'}
}

------------------------------------------------------------
-- Scala (nvim-metals)
------------------------------------------------------------
-- (For Scala, I use nvim-metals, not lspconfig)
-- See here https://github.com/scalameta/nvim-metals/discussions/39
-- for an example configuration.
vim.opt_global.shortmess:remove("F"):append("c")

-- Augroup
vim.cmd([[augroup lsp]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]])
vim.cmd([[augroup end]])

-- Needed for symbol highlights to work correctly
vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])

metals_config = require("metals").bare_config()
metals_config.capabilities = capabilities

----------------------------------------------------------------------
-- Diagnostics
----------------------------------------------------------------------
require"trouble".setup {}

----------------------------------------------------------------------
-- Hover docs
----------------------------------------------------------------------

local printer = function(_, _, result)
  if not (result)
  then
    print(" ")
    return
  end
  if (type(result) == "number")
  then
    print(" ")
    return
  end
  if not (result.contents)
  then
    print(" ")
    return
  end
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

  if vim.tbl_isempty(markdown_lines)
  then
    print(" ")
    return
  end
  local first_type_line = markdown_lines[2]
  print(first_type_line)
end

return {
 print_hover_doc = function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0,'textDocument/hover', params, printer)
  end
}
