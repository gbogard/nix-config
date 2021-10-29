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
    },
    g = {
      name = 'Go to',
      d = {'<Cmd>lua vim.lsp.buf.definition()<CR>', 'definition'},
      D = {'<Cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration'}
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

-- Doc on hover
vim.api.nvim_command('augroup InlineHover')
vim.api.nvim_command('autocmd CursorHold * :silent! lua require("lsp").print_hover_doc() ')
vim.api.nvim_command('augroup END')

