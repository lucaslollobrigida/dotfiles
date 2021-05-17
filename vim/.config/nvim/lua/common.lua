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

return M
