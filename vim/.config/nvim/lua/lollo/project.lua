local has_contabs = pcall(vim.cmd, [[packadd nvim-contabs]])
if not has_contabs then
  print('[Project] nvim-contabs is required for this package.')
  return
end

vim.cmd [[packadd vim-fugitive]]
vim.cmd [[packadd vim-projectionist]]
vim.cmd [[packadd fzf]]
vim.cmd [[packadd fzf.vim]]
vim.cmd [[packadd fzf-checkout.vim]]

local function nnoremap(mapping, action, silent)
  local silent = silent or false
  vim.api.nvim_set_keymap('n', mapping, action, { noremap = true })
end

vim.g['contabs#project#locations'] = {
  {path = '~/dev/',       depth = 2, git_only = false},
  {path = '~/.dotfiles/', depth = 0, git_only = true, entrypoint = {'vim/.config/nvim/init.lua'}},
}

nnoremap('<leader>b', ':GBranches<cr>')
nnoremap('<leader>g', '<cmd>lua require("neogit").status.create("split")<cr>')

nnoremap('<leader>p', ':call contabs#project#select()<CR>', true)
nnoremap('<leader>,', ':call contabs#buffer#select()<CR>', true)
