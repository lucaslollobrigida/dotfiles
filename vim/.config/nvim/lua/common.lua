P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

local M = {}

function M.path_short(path)
  local match_string = "[^/]+[/][^/]+$"

  return string.match(path, match_string)
end

local function notification_dimentions(lines)
  local rows = vim.o.lines - #lines - vim.o.cmdheight - 2
  local columns = vim.o.columns - vim.wo.numberwidth - 2
  local width = math.ceil(columns * 0.3)
  local height = #lines

  return rows, columns, width, height
end

local function hl_from_level(log_level)
  if log_level == vim.log.levels.ERROR then
    return "ErrorMsg"
  elseif log_level == vim.log.levels.WARN then
    return "WarningMsg"
  else
    return "NormalMsg"
  end
end

function M.notify(msg, opts)
  local is_multiline = vim.tbl_islist(msg)

  if not msg or is_multiline and vim.tbl_isempty(msg) then
    return
  end

  local duration = opts.duration or 3000
  local lines = is_multiline and msg or { msg }

  local rows, columns, width, height = notification_dimentions(lines)

  local win_opts = {
    row = rows,
    col = columns,
    relative = "editor",
    style = "minimal",
    width = math.min(width, 60),
    height = height,
    anchor = "SE",
    focusable = false,
    border = "single",
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, win_opts)
  local highlight = hl_from_level(opts.log_level)

  vim.wo[win].winhighlight = string.format("NormalFloat:%s", highlight)
  vim.wo[win].wrap = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

  vim.wo[win].winblend = 5
  vim.bo[buf].modifiable = false

  vim.fn.timer_start(duration, function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end)
end

vim.notify = function(msg, log_level)
  local opts = { log_level = log_level, duration = 5000 }
  require("common").notify(msg, opts)
end

return M
