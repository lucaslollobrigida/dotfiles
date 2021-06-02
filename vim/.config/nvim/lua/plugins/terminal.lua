local M = {}

M.open_term = function()
  -- local win = win_nr or vim.api.nvim_get_current_win()
  local bnr = vim.api.nvim_create_buf(false, true)

  if bnr > 0 then
    vim.cmd("botright split")
    local winnr = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(winnr, bnr)
    vim.api.nvim_win_set_height(0, 10)

    vim.call("termopen", "$SHELL")

    vim.bo.filetype = "terminal"
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.scrolloff = 0
    vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<c-\><c-n>]], { noremap = true })

    vim.cmd("startinsert")
  end
end

return M
