" Plugin: dirvish
let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
call dirvish#add_icon_fn({p -> WebDevIconsGetFileTypeSymbol(p)})
