vim.cmd('set completeopt=menuone,noinsert,noselect')

local custom_attach = function(client, bfnr)
    print("LSP started.");
    require'keybindings'.attach_lsp_keybindings(bfnr)
end

require'lspsaga'.init_lsp_saga()

-- Completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
  };
}

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
-- Rescript
lspconfig.rescriptls.setup{
  cmd = { 'node', vim.env.HOME .. '/.nix-profile/rescriptls/extension/server/out/server.js', '--stdio'};
  root_dir = lspconfig.util.root_pattern("bsconfig.json", ".git");
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
