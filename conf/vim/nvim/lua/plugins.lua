local C = require "config"

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = C.paths.data .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
  local plugin_prefix = C.paths.data .. "/site/pack/packer/opt/"

  local plugin_path = plugin_prefix .. plugin .. "/"
  local ok, err, code = os.rename(plugin_path, plugin_path)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end

  if ok then
    vim.cmd("packadd " .. plugin)
  end
  return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile"

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  require("modules.telescope").plugins(use)
  require("modules.treesitter").plugins(use)
  require("modules.lsp").plugins(use)
  require("modules.file_browser").plugins(use)
  require("modules.git").plugins(use)
  require("modules.ui").plugins(use)
  require("modules.editing").plugins(use)
  require("modules.project").plugins(use)
  require("modules.lang.clojure").plugins(use)
  require("modules.lang.dart").plugins(use)
  require("modules.lang.go").plugins(use)
  require("modules.lang.rust").plugins(use)
  require("modules.lang.scala").plugins(use)
  require("modules.lang.typescript").plugins(use)

  -- temp
  use("aklt/plantuml-syntax")
  use("tyru/open-browser.vim")
  use("weirongxu/plantuml-previewer.vim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

require("modules.telescope").lazy_load(require_plugin)
require("modules.treesitter").lazy_load(require_plugin)
require("modules.lsp").lazy_load(require_plugin)
require("modules.file_browser").lazy_load(require_plugin)
require("modules.git").lazy_load(require_plugin)
require("modules.ui").lazy_load(require_plugin)
require("modules.editing").lazy_load(require_plugin)
require("modules.project").lazy_load(require_plugin)
require("modules.lang.clojure").lazy_load(require_plugin)
require("modules.lang.dart").lazy_load(require_plugin)
require("modules.lang.go").lazy_load(require_plugin)
require("modules.lang.scala").lazy_load(require_plugin)
require("modules.lang.rust").lazy_load(require_plugin)
require("modules.lang.typescript").lazy_load(require_plugin)
