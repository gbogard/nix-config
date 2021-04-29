local wk = require('whichkey_setup')

local keymap = {
    ['<SPC'] = {'<Cmd>Telescope find_files,<CR>', 'Find files'},
    c = {
	name = 'Code',
	a = {'<cmd>Lspsaga code_action<CR>', 'Action'},
	d = {'<cmd>Lspsaga show_line_diagnostics<CR>', 'Show line diagnostic'},
	f = {'<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format current buffer'},
	h = {'<cmd>Lspsaga hover_doc<CR>', 'Hover doc'},
	r = {'<cmd>Lspsaga rename<CR>', 'Rename'}
    },
    b = {
	    name = 'Buffer', 
	    f = {'<Cmd>Telescope buffers<CR>', 'find'}
    },
    f = {
        name = "File",
        t = {'<Cmd>NvimTreeToggle<CR>', 'tree'},
        f = {'<Cmd>Telescope find_files<CR>', 'find'},
        w = {':w!<CR>', 'save'}
    },
    g = {
        name = 'Git',
        g = {'<Cmd>Telescope git_commits<CR>', 'commits'},
        c = {'<Cmd>Telescope git_bcommits<CR>', 'bcommits'},
        b = {'<Cmd>Telescope git_branches<CR>', 'branches'},
        s = {'<Cmd>Telescope git_status<CR>', 'status'}
    }
}

wk.register_keymap('leader', keymap)
return {
    attach_lsp_keybindings = function(bufnr)
        local opts = {noremap = true, silent = true}
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',
                       opts)
        buf_set_keymap('n', '<C-k>',
                       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    end
}

