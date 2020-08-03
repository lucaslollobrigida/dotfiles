function! GetNVimVersion()
  redir => s
  silent! version
  redir END
  return matchstr(s, 'NVIM v\zs[^\n]*')
endfunction

" Temporary
function! LSPEnable()
  let nvim_version = GetNVimVersion()
  return (nvim_version == "0.5.0") || (nvim_version == "0.5.0-dev")
endfunction

function! DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

function! TrimWS()
  %s/\s\+$//e
endfunction

function! RemoveTabs()
  %s/\t/  /ge
endfunction

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

function! SetProjections(ft)
  let l:base_file = a:ft . '_projections.json'
  let l:global_jsn = expand('$XDG_CONFIG_HOME/nvim/resources/') . l:base_file
  if filereadable(l:global_jsn)
    let l:json = readfile(l:global_jsn)
    let l:dict = projectionist#json_parse(l:json)
    call projectionist#append(getcwd(), l:dict)
  endif
endfunction

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

