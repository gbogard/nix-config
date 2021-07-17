local wk = require("which-key")

local keymap = {
    ['<leader>'] = {
        ['<leader>'] = {'<Cmd>Telescope find_files<CR>', 'Find'},
        c = {
            name = 'Code',
            a = {'<cmd>Lspsaga code_action<CR>', 'Action'},
            d = {
                '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show line diagnostic'
            },
            D = {'<cmd>LspTroubleToggle<CR>', 'Show workspace diagnostics'},
            f = {
                '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format current buffer'
            },
            h = {'<cmd>Lspsaga hover_doc<CR>', 'Hover doc'},
            r = {'<cmd>Lspsaga rename<CR>', 'Rename'}
        },
        b = {name = 'Buffer', f = {'<Cmd>Telescope buffers<CR>', 'find'}},
        f = {
            name = "File",
            f = {'<Cmd>Telescope find_files<CR>', 'find'},
            g = {'<Cmd>Telescope live_grep<CR>', 'grep'},
            t = {'<Cmd>:NvimTreeOpen<CR><Cmd>:NvimTreeFindFile<CR>', 'reveal in tree'},
            w = {':w!<CR>', 'save'}
        },
        g = {
            name = 'Git',
            g = {'<Cmd>Telescope git_commits<CR>', 'commits'},
            c = {'<Cmd>Telescope git_bcommits<CR>', 'bcommits'},
            b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
            s = {'<Cmd>Telescope git_status<CR>', 'status'}
        },
        h = {'<Cmd>HoogleOpen<CR>', 'Open Hoogle'}
    }
}

wk.register(keymap)
wk.setup {}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

return {
    attach_lsp_keybindings = function(bufnr)
        local opts = {noremap = true, silent = true}
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
                       opts)
        buf_set_keymap('n', '<C-k>',
                       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

       vim.api.nvim_command('augroup InlineHover')
       vim.api.nvim_command('autocmd CursorHold * :lua require("lsp").print_hover_doc() ')
       vim.api.nvim_command('augroup END')
    end
}

