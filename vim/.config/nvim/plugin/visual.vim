" Author: Lucas Lollobrigida
" Repository: https://github.com/lucaslollobrigida/dotfiles
" Visual set of configurations for vim

" Use gui colors
set termguicolors
highlight Comment cterm=Italic

" Plugin: gruvbox
" let g:gruvbox_italic=1

" try
"   colorscheme gruvbox
" endtry

"Plugin: sonokai
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 0

try
  colorscheme sonokai
endtry

" Plugin: lightline.vim
let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'readonly': 'LightlineReadonly',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

" Plugin: float-preview.nvim
let g:float_preview#docked = 0
set completeopt-=preview
