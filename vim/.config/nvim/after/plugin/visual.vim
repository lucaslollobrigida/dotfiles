" Author: Lucas Lollobrigida
" Repository: https://github.com/lucaslollobrigida/dotfiles
" Visual set of configurations for vim

call cyclist#add_listchar_option_set('limited', {
        \ 'eol': '↲',
        \ 'tab': '» ',
        \ 'trail': '·',
        \ 'extends': '<',
        \ 'precedes': '>',
        \ 'conceal': '┊',
        \ 'nbsp': '␣',
        \ })

call cyclist#add_listchar_option_set('busy', {
        \ 'eol': '↲',
        \ 'tab': '»·',
        \ 'space': '␣',
        \ 'trail': '-',
        \ 'extends': '☛',
        \ 'precedes': '☚',
        \ 'conceal': '┊',
        \ 'nbsp': '☠',
        \ })

call cyclist#activate_listchars('limited')

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
hi Normal guibg=none

" Plugin: sonokai
" try
"   colorscheme sonokai
"   let g:sonokai_style = 'andromeda'
"   let g:sonokai_enable_italic = 1
"   let g:sonokai_disable_italic_comment = 0
" endtry

" Plugin: palenight
try
  colorscheme palenight
  let g:palenight_terminal_italics=1
endtry

hi Comment cterm=Italic gui=italic

hi CursorLine guibg=#6A3EB5 guifg=white
" hi CursorLine guibg=Violet guifg=white

" hi NormalFloat ctermbg=black guibg=black

hi ColorColumn  term=reverse ctermbg=1 guibg=#3E4452
hi! link ColorColumn Comment

" CocExplorer palenight
highlight def link CocExplorerFileFullpath StatusLineNC
highlight def link CocExplorerFileDirectory StatusLineNC
highlight def link CocExplorerFileGitStage StatusLineNC
highlight def link CocExplorerFileGitUnstage StatusLineNC
highlight def link CocExplorerFileSize StatusLineNC
highlight def link CocExplorerTimeAccessed StatusLineNC
highlight def link CocExplorerTimeCreated StatusLineNC
highlight def link CocExplorerTimeModified StatusLineNC
highlight def link CocExplorerFileRootName StatusLineNC
highlight def link CocExplorerFileExpandIcon StatusLineNC

highlight def link CocExplorerIndentLine LineNR

highlight def link CocExplorerFileDirectoryExpanded statement
highlight def link CocExplorerFileDirectoryCollapsed statement
highlight def link CocExplorerBufferRoot statement
highlight def link CocExplorerBufferExpandIcon statement
highlight def link CocExplorerFileRoot statement
highlight def link CocExplorerFileExpandIcon statement
highlight def link CocExplorerSelectUI statement

hi! link VertSplit StatusLineNC
hi! link Split StatusLineNC
