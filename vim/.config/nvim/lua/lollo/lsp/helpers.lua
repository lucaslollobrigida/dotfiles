local M = {}

M.current_file_url = function()
  local file = vim.api.nvim_eval([[expand('%:p')]])
  return string.format('file://%s', file)
end

M.clojure_clean_ns = function()
  local file = M.current_file_url()
  vim.lsp.buf.execute_command({command = 'clean-ns', arguments = {file, 1, 1}})
end

M.clojure_clean_ns_sync = function(timeout_ms)
  local params = {command = 'clean-ns', arguments = {M.current_file_url(), 1, 1}}
  local result = vim.lsp.buf_request_sync(0, "workspace/executeCommand", params, timeout_ms)
  if not result or vim.tbl_isempty(result) then return end
  local _, formatting_result = next(result)
  result = formatting_result.result
  if not result then return end
  vim.lsp.util.apply_text_edits(result)
end

return M
