" Plugin: nvim-contabs
let g:contabs#project#locations = [
  \ { 'path': '~/dev/', 'depth': 2, 'git_only': v:true },
  \ { 'path': '~/zettelkasten/', 'depth': 0, 'git_only': v:true, 'entrypoint': [ 'c18e9987.md' ], 'formatter': { _ -> 'notes (~/zettelkasten)' } },
  \ { 'path': '~/vimwiki/', 'depth': 0, 'git_only': v:true, 'entrypoint': [ 'index.md' ], 'formatter': { _ -> 'wiki (~/vimwiki)' } },
  \ { 'path': '~/.dotfiles/', 'depth': 0, 'git_only': v:true, 'entrypoint': [ 'vim/.config/nvim/init.vim' ], 'formatter': { _ -> 'dotfiles (~/.dotfiles)' }},
  \]

" Plugin: fzf.vim
" let g:fzf_preview_window = 'right:60%'
