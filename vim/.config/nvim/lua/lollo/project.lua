local has_contabs = pcall(Packadd, 'nvim-contabs')
if not has_contabs then
  print('[Project] nvim-contabs is required for this package.')
  return
end

Packadd [[vim-fugitive]]
Packadd [[vim-projectionist]]
Packadd [[vim-rhubarb]]
Packadd [[fzf]]
Packadd [[fzf.vim]]

vim.g['contabs#project#locations'] = {
  {path = '~/dev/nu'      , depth = 1, git_only = true},
  {path = '~/dev/personal', depth = 2, git_only = false},
  {path = '~/.dotfiles/'  , depth = 0, git_only = true, entrypoint = {'vim/.config/nvim/init.lua'}},
}

Nnoremap {'<leader>g', '<cmd>lua require("neogit").status.create("split")<cr>'}

Nnoremap {'<leader>p', ':call contabs#project#select()<CR>', silent = true}
Nnoremap {'<leader>,', ':call contabs#buffer#select()<CR>', silent = true}
