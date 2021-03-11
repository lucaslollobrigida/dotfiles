local function nnoremap(mapping, action)
  vim.api.nvim_set_keymap('n', mapping, action, { noremap = true })
end

local function xnoremap(mapping, action)
  vim.api.nvim_set_keymap('x', mapping, action, { noremap = true })
end

local function silent_nnoremap(mapping, action)
  vim.api.nvim_set_keymap('n', mapping, action, { noremap = true, silent = true })
end

local function nvnoremap(mapping, action)
  vim.api.nvim_set_keymap('n', mapping, action, { noremap = true })
  vim.api.nvim_set_keymap('v', mapping, action, { noremap = true })
end

local function cmap(mapping, action)
  vim.api.nvim_set_keymap('c', mapping, action, { noremap = false })
end

-- leader keys
vim.api.nvim_set_var('mapleader', ' ')
vim.api.nvim_set_var('maplocalleader', ',')

-- disable ex-mode
nnoremap('Q', '')
nnoremap('gQ', '')

nvnoremap(';', ':')
nvnoremap(':', ';')

-- forget to `sudo vim` some file
cmap('w!!', 'w !sudo tee > /dev/null %')

-- window
nnoremap('<C-+>', '<C-w>+') -- FIXME: this is broken
nnoremap('<C-_>', '<C-w>-')

-- search
silent_nnoremap('<leader>n', ':nohlsearch<CR>')

-- managing files
nnoremap("<leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- buffers
nnoremap('<leader>q', ':bprevious<CR>')
nnoremap('<leader>w', ':bnext<CR>')
nnoremap('<leader>c', ':bdelete!<CR>')
nnoremap('<leader>.', ':lcd %:p:h<CR>')

-- tabs
nnoremap('<leader>t', ':tabnew<CR>')
nnoremap('<Tab>', ':tabnext<CR>')
nnoremap('<S-Tab>', ':tabprevious<CR>')

-- sessions
nnoremap('<leader>sw', ':mksession! .quicksave.vim<CR>:echo "Session saved."<CR>')
nnoremap('<leader>sr', ':source .quicksave.vim<CR>:echo "Session loaded."<CR>')

-- format
nnoremap('<leader>tw', ':call TrimWS()<CR>')
nnoremap('<leader>rt', ':call RemoveTabs()<CR>')

-- keep in visual mode while indenting some piece of text
xnoremap('<', '<gv')
xnoremap('>', '>gv')

nnoremap('<leader>sh', [[<cmd>lua require('experiments.terminal').open_term()<cr>]])

-- format
nnoremap('<leader>tw', [[<cmd>%s/\s\+$//e<cr>]])
nnoremap('<leader>rt', [[<cmd>%s/\t/  /ge<cr>]])
