-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set

set({ "n", "v" }, ";", ":", { desc = "Enter command mode" })
set({ "n", "v" }, ":", ";", { desc = "" })

-- disable ex-mode
set({ "n" }, "Q", "")
set({ "n" }, "gQ", "")

set({ "c" }, "w!!", "w !sudo tee > /dev/null %", { desc = "Save using sudo user" })

set({ "n" }, "<leader>n", ":nohlsearch<CR>", { silent = true, desc = "Clean search results" })

set({ "n" }, "<leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>', { desc = "Edit files on current folder" })

-- buffers
set({ "n" }, "<leader>c", ":bdelete!<CR>", { silent = true, desc = "Delete current buffer" })
set({ "n" }, "<leader>.", ":lcd %:p:h<CR>", { silent = true, desc = "Change directory to current file directory" })
set({ "n" }, "<Tab>", "<cmd>bnext<cr>", { silent = true, desc = "Next buffer" })
set({ "n" }, "<S-Tab>", "<cmd>bprevious<cr>", { silent = true, desc = "Previous buffer" })

-- -- format
-- set({ "n" }, "<leader>tw", [[<cmd>%s/\s\+$//e<cr>]])
-- set({ "n" }, "<leader>rt", [[<cmd>%s/\t/  /ge<cr>]])
--
--
-- -- files
-- set({ "n" }, "<leader>f", [[<cmd>lua require('modules.telescope').project_files()<cr>]])
--
-- -- file browser
-- set({ "n" }, "-", [[<cmd>lua require('modules.file_browser').file_browser()<CR>]])
--
-- -- git
-- set({ "n" }, "<leader>b", [[<cmd>lua require('modules.telescope').git_branches()<CR>]])
-- set({ "n" }, "<leader>g", '<cmd>lua require("neogit").open{kind="split"}<cr>')
--
-- -- project
-- set({ "n" }, "<leader>p", [[<cmd>lua require('modules.telescope').browse_projects()<CR>]])
--
-- -- Align
-- set({ "n" }, "ga", "<Plug>(EasyAlign)")
-- xnoremap("ga", "<Plug>(EasyAlign)")
-- set({ "n" }, "<leader><leader>", [[<cmd>exe "normal vif"<CR>|<cmd>'<,'>EasyAlign 1\<CR>]])
-- vnoremap("<leader><leader>", [[<cmd>'<,'>EasyAlign 1\<CR>]])
