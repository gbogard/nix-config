require'lspsaga'.init_lsp_saga()

-- Completion symbols
require('lspkind').init({
    with_text = true,
    symbol_map = {
      Text = '',
      Method = 'ƒ',
      Function = '',
      Constructor = '',
      Variable = '',
      Class = '',
      Interface = 'ﰮ',
      Module = '',
      Property = '',
      Unit = '',
      Value = '',
      Enum = '了',
      Keyword = '',
      Snippet = '﬌',
      Color = '',
      File = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = ''
    }
})

-- Completion sources
vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'buffers' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } }
  },
}

local custom_attach = function(client, bfnr)
    print("LSP started.");
    require'keybindings'.attach_lsp_keybindings(bfnr);
    require'completion'.on_attach(client, bnfr);
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local serverOptions = {
  on_attach = custom_attach,
  init_options = { usePlaceholders = true },
  capabilities = capabilities
}
local lspconfig = require "lspconfig"

-- Scala
lspconfig.metals.setup(serverOptions)
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
-- CSS
lspconfig.cssls.setup{
  cmd = {vim.env.HOME .. '/.nix-profile/bin/vscode-css-language-server', '--stdio'}
}
-- JSON
lspconfig.jsonls.setup{
  cmd = {vim.env.HOME .. '/.nix-profile/bin/vscode-json-language-server', '--stdio'}
}

-- Diagnostics
require"trouble".setup {}

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
