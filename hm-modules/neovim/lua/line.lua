require('lualine').setup {
  options = {
    theme = 'gruvbox_material',
    section_separators = ''
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch', 
      {"diagnostics", sources = {"nvim_lsp"}}
    },
    lualine_c = {'g:metals_status'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
