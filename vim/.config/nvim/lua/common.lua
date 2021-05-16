local selection = require("nvim-treesitter.incremental_selection")
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

function M.align()
  selection.init_selection()
  selection.node_incremental()
  -- vim.cmd([[EasyAlign 1\]])
end

return M
