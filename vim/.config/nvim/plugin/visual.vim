" Author: Lucas Lollobrigida
" Repository: https://github.com/lucaslollobrigida/dotfiles
" Visual set of configurations for vim

" Use gui colors
set termguicolors
highlight Comment cterm=Italic

highlight NormalFloat ctermbg=black guibg=black

"Plugin: sonokai
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 0

try
  colorscheme sonokai
endtry

" Plugin: float-preview.nvim
let g:float_preview#docked = 0
set completeopt-=preview
