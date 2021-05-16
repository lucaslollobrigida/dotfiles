----- syntax
vim.bo.syntax = "ON"
vim.o.termguicolors = true
vim.o.showmode = false

vim.o.mouse = "a"

vim.bo.smartindent = true
vim.o.expandtab = true
vim.cmd("set ts=4") -- Insert 2 spaces for a tab
vim.cmd("set sw=4") -- Change the number of space characters inserted for indentation

---- ruler and cursor line
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.cursorline = true

----- sane splits
vim.o.splitbelow = true
vim.o.splitright = true

---- disable folding
vim.wo.foldenable = false

----- fill and use clipboard register on text edits
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else

--
vim.cmd([[set shortmess+=c]])

-- treat dash separated words as a word text object"
vim.cmd([[set iskeyword+=-]])

----- disable unused default plugins
vim.g.loaded_2html_plugin = true

----- automatically write on focus change and load changes from outside vim's to the buffer
vim.o.autoread = true
vim.o.autowrite = true

----- tweak update and redraw timers
vim.o.updatetime = 600
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeout = true
vim.o.ttyfast = true
vim.o.lazyredraw = true

----- disable swapfiles
vim.bo.swapfile = false

----- make inccommand opens a split with live preview of the search (neovim only)
vim.o.inccommand = "split"

vim.o.hidden = true
vim.o.wrap = false

vim.o.undofile = true
vim.o.undolevels = 10000

vim.o.scrolloff = 10

----- completion tweak
vim.o.completeopt = "menu,menuone,noselect"

if vim.fn.has("nvim-0.5") then
  vim.cmd([[
    augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank()
    augroup END
  ]])
end

---- NEW
vim.o.title = true

TERMINAL = vim.fn.expand("$TERMINAL")
vim.cmd('let &titleold="' .. TERMINAL .. '"')
vim.o.titlestring = "%<%F%=%l/%L - nvim"

vim.cmd("set whichwrap+=<,>,[,],h,l") -- move to next line with theses keys
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.cmd("set colorcolumn=99999") -- fix indentline for now

vim.o.t_Co = "256" -- Support 256 colors
vim.o.conceallevel = 0 -- So that I can see `` in markdown files

vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

-- vim.o.guifont = "JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"
-- vim.o.guifont = "FiraCode Nerd Font:h17"
-- vim.o.guifont = "JetBrains\\ Mono\\ Regular\\ Nerd\\ Font\\ Complete"
