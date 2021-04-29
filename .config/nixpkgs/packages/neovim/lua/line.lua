require('lualine').setup {
  options = {
    theme = 'palenight',
    section_separators = ''
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch', 
      {"diagnostics", sources = {"nvim_lsp"}}
    },
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
