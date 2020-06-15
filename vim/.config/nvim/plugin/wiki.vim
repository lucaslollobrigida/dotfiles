" Plugin: vimwiki
let g:vimwiki_list = [{
            \ 'path_html': '$HOME/vimwiki/html',
            \ 'path': '$HOME/vimwiki',
            \ 'template_path': '$HOME/vimwiki/templates/',
            \ 'template_default':'default',
            \ 'syntax': 'markdown',
            \ 'ext':'.md',
            \ 'custom_wiki2html': 'vimwiki_markdown',
            \}]
let g:taskwiki_syntax = 'markdown'
let g:taskwiki_markdown_syntax='markdown'
let g:taskwiki_markup_syntax='markdown'
let g:vimwiki_folding='expr'
let g:vimwiki_hl_headers = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown'}

