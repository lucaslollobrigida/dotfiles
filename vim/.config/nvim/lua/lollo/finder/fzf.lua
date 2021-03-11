vim.cmd [[packadd fzf]]
vim.cmd [[packadd fzf.vim]]

local function nnoremap(mapping, action)
  vim.api.nvim_set_keymap('n', mapping, action, { noremap = true })
end

-- search
nnoremap('<leader>s', ':Rg<CR>')
nnoremap('<leader>*', ':Rg <C-R>=expand("<cword>")<CR><CR>')

-- files
nnoremap('<leader>f', ':Files<CR>')
nnoremap('<leader><leader>', ':GFiles<cr>')

-- buffers
nnoremap('<leader>,', ':Buffers<cr>')
