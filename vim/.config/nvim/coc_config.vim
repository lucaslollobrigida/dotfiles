" Current configuration based on Coc for LSP
" Author: Lucas Lollobrigida
" Repository: https://github.com/lucaslollobrigida/dotfiles

" Check if vim-pug is installed
let plugtarget = '~/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(plugtarget))
  echom "Installing vim-plug..."
  try
    let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . plugtarget . ' --create-dirs ' . plugurl)
    autocmd VimEnter * PlugInstall
  catch
    echo "vim-plug couldn't be installed."
  endtry
endif

call plug#begin('~/.local/share/nvim/plugged')

" Visual
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/sonokai'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'ncm2/float-preview.nvim'
Plug 'norcalli/nvim-terminal.lua'
Plug 'tjdevries/cyclist.vim'
Plug 'Shougo/echodoc.vim'
Plug 'machakann/vim-highlightedyank'

" Focus mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release', 'for': 'clojure'}
Plug 'junegunn/vim-easy-align'
" Plug 'jiangmiao/auto-pairs'

" Project
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'm00qek/nvim-contabs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'voldikss/vim-floaterm'

" REPL integration
Plug 'clojure-vim/vim-jack-in', {'for': 'clojure'}
Plug 'Olical/conjure' | Plug 'Olical/AnsiEsc'

" LSP Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Diagram and Documentation
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

" Syntax
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'
Plug 'dart-lang/dart-vim-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'LnL7/vim-nix'
Plug 'aklt/plantuml-syntax'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'natebosch/dartlang-snippets'

" Notetaking
Plug 'ihsanturk/neuron.vim'

call plug#end()

" Plugin: others
let dart_style_guide = 2

" Plugin: echodoc
set noshowmode
let g:echodoc_enable_at_startup = 1

" Plugin: coc.nvim
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

" Plugin: Lightline
let g:lightline = {
  \ 'colorscheme': 'palenight',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'cocerror', 'cocwarn', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'ft_icon' ] ] },
  \ 'inactive': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \            [ 'percent' ],
  \            [ 'ft_icon' ] ] },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'fugitive': 'LightlineFugitive',
  \   'ft_icon': 'FileTypeWithIcon',
  \   'ff_icon': 'FileFormatWithIcon',
  \ },
  \ 'component_expand': {
  \   'cocerror': 'LightLineCocError',
  \   'cocwarn' : 'LightLineCocWarn',
  \ },
  \ 'component_type': {
  \   'cocerror': 'error',
  \   'cocwarn' : 'warning',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! FileTypeWithIcon() abort
  let filetype_with_icon = &filetype !=# '' ? &filetype : 'no ft'
  return winwidth(0) > 70 ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : ' '
endfunction

function! FileFormatWithIcon() abort
  let fileformat_with_icon = &fileformat !=# '' ? &fileformat : 'no ff'
  return winwidth(0) > 70 ? WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat : ' '
endfunction

function! LightLineCocError()
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif

  let errmsgs = []

  if get(info, 'error', 0)
    let s:error_sign = get(g:, 'coc_status_error_sign', '✘ ')
    call add(errmsgs, s:error_sign . info['error'])
  endif

  return trim(join(errmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
endfunction

function! LightLineCocWarn() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info)
    return ''
  endif

  let warnmsgs = []

  if get(info, 'warning', 0)
    let s:warning_sign = get(g:, 'coc_status_warning_sign', ' ')
    call add(warnmsgs, s:warning_sign . info['warning'])
  endif

  return trim(join(warnmsgs, ' ') . ' ' . get(g:, 'coc_status', ''))
endfunction


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType clojure,typescript,json setl formatexpr=CocAction('formatSelected')
  " Autoorganize imports on save
  autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocDiagnosticChange call lightline#update()
  " highlight symbol under cursor
  autocmd CursorHold  * silent call CocActionAsync('highlight')
  autocmd CursorHoldI * silent call CocActionAsync('highlight')
augroup end

let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-conjure',
      \ 'coc-elixir',
      \ 'coc-flutter',
      \ 'coc-go',
      \ 'coc-highlight',
      \ 'coc-json',
      \ 'coc-rust-analyzer',
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ ]

augroup ClojureContent
  autocmd!
  autocmd BufReadCmd,FileReadCmd,SourceCmd jar:file://* call s:LoadClojureContent(expand("<amatch>"))
augroup END

 function! s:LoadClojureContent(uri)
  setfiletype clojure
  let content = CocRequest('clojure-lsp', 'clojure/dependencyContents', {'uri': a:uri})
  call setline(1, split(content, "\n"))
  setl nomodified
  setl readonly
endfunction

command! -nargs=0 Format :call CocAction('format')

" Plugin: vim-highlightedyank
let g:highlightedyank_highlight_duration = 300

" Plugin: float-preview.nvim
let g:float_preview#docked = 0
set completeopt-=preview

fu s:snr() abort
    return matchstr(expand('<sfile>'), '.*\zs<SNR>\d\+_')
endfu
let s:snr = get(s:, 'snr', s:snr())
let g:fzf_layout = {'window': 'call '..s:snr..'fzf_window(0.9, 0.6, "Comment")'}

fu s:fzf_window(width, height, border_highlight) abort
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)
    let top = '┌' . repeat('─', width - 2) . '┐'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '└' . repeat('─', width - 2) . '┘'
    let border = [top] + repeat([mid], height - 2) + [bot]
    if has('nvim')
        let frame = s:create_float(a:border_highlight, {
            \ 'row': row,
            \ 'col': col,
            \ 'width': width,
            \ 'height': height,
            \ })
        call nvim_buf_set_lines(frame, 0, -1, v:true, border)
        call s:create_float('Normal', {
            \ 'row': row + 1,
            \ 'col': col + 2,
            \ 'width': width - 4,
            \ 'height': height - 2,
            \ })
        exe 'au BufWipeout <buffer> bw '..frame
    else
        let frame = s:create_popup_window(a:border_highlight, {
            \ 'line': row,
            \ 'col': col,
            \ 'width': width,
            \ 'height': height,
            \ 'is_frame': 1,
            \ })
        call setbufline(frame, 1, border)
        call s:create_popup_window('Normal', {
            \ 'line': row + 1,
            \ 'col': col + 2,
            \ 'width': width - 4,
            \ 'height': height - 2,
            \ })
    endif
endfu

fu s:create_float(hl, opts) abort
    let buf = nvim_create_buf(v:false, v:true)
    let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:'..a:hl)
    return buf
endfu

fu s:create_popup_window(hl, opts) abort
    if has_key(a:opts, 'is_frame')
        let id = popup_create('', #{
            \ line: a:opts.line,
            \ col: a:opts.col,
            \ minwidth: a:opts.width,
            \ minheight: a:opts.height,
            \ zindex: 50,
            \ })
        call setwinvar(id, '&wincolor', a:hl)
        exe 'au BufWipeout * ++once call popup_close('..id..')'
        return winbufnr(id)
    else
        let buf = term_start(&shell, #{hidden: 1})
        call popup_create(buf, #{
            \ line: a:opts.line,
            \ col: a:opts.col,
            \ minwidth: a:opts.width,
            \ minheight: a:opts.height,
            \ zindex: 51,
            \ })
        exe 'au BufWipeout * ++once bw! '..buf
    endif
endfu
