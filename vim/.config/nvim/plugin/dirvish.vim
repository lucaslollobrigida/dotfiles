" Plugin: dirvish
let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
call dirvish#add_icon_fn({p -> WebDevIconsGetFileTypeSymbol(p)})

nnoremap <buffer> D :Shdo rm -r {}<CR>
