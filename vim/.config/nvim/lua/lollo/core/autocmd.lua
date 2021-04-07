local bo = vim.bo
local api = vim.api

function help_extras()
  if bo.buftype == 'help' then
    local nr = api.nvim_get_current_buf()
    local close = [[:q<CR>]]
    Nnoremap {'q',     close, buffer = nr, silent = true}
    Nnoremap {'<esc>', close, buffer = nr, silent = true}
  end
end

Nvim_multiline_command [[
  augroup help_extra
  au!
  au BufEnter *.txt lua help_extras()
  augroup END
]]

if vim.fn.has('nvim-0.5') then
  Nvim_multiline_command [[
    augroup highlight_yank
    au!
    au TextYankPost * silent! lua vim.highlight.on_yank()
    augroup END
  ]]
end

return {
  help_extras
}
