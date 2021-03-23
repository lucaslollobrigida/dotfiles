local M = {}

vim.cmd [[ hi GreenBar term=reverse ctermfg=white ctermbg=green guifg=white guibg=green ]]
vim.cmd [[ hi RedBar   term=reverse ctermfg=white ctermbg=red guifg=white guibg=red ]]

-- local report = {
--   summary = {
--     passed = 13,
--     failed = 1,
--     skipped = 0,
--   },
--   errors = {
--     {
--       test = 'test.user/hash-password-test',
--       output = 'Null pointer exception!',
--     }
--   },
-- }

local function clojure_reporter(result)
  local summary = {failed = false, passed_count = 19}
  print(result)
  -- local summary = {failed = true, errors = {{msg = 'Null Pointer ...'}}}
  return summary
end

local reporters = {
  clojure = clojure_reporter,
}

local function report_error(error)
  vim.cmd [[ echohl RedBar ]]
  local msg = 'A spec have failed: ' .. error
  vim.cmd("echon '" .. msg .. "'")
  vim.cmd [[ echohl None ]]
end

local function report_sucess(count)
  vim.cmd [[ echohl GreenBar ]]
  local msg = 'All ' .. count .. ' tests have passed.'
  vim.cmd("echon '" .. msg .. "'")
  vim.cmd [[ echohl None ]]
end

M.report = function(result)
  local filetype = 'clojure'
  local report = reporters[filetype](result)
  if report.summary.failed > 0 then
    report_error(report.errors[1])
    return
  end

  report_sucess(report.summary.passed)
end

return M
