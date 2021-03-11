local bo = vim.bo
local api = vim.api

local function nvim_multiline_command(command)
  vim.validate { command = { command, 's' } }
  for line in vim.gsplit(command, "\n", true) do
    api.nvim_command(line)
  end
end

function help_extras ()
  if bo.buftype == 'help' then
    local nr = api.nvim_get_current_buf()
    api.nvim_buf_set_keymap(nr, "n", "q", ":q<CR>", { noremap = true, silent = true })
    api.nvim_buf_set_keymap(nr, "n", "<esc>", ":q<CR>", { noremap = true, silent = true })
  end
end

nvim_multiline_command [[
  augroup help_extra
  au!
  au BufEnter *.txt lua help_extras()
  augroup END
]]

if vim.fn.has('nvim-0.5') then
  nvim_multiline_command [[
    augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank()
    augroup END
  ]]
end

