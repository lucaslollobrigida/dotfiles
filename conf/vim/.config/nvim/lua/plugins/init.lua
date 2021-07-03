local C = require("config")

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = C.paths.data .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute("packadd packer.nvim")
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
  local plugin_prefix = C.paths.data .. "/site/pack/packer/opt/"

  local plugin_path = plugin_prefix .. plugin .. "/"
  --	print('test '..plugin_path)
  local ok, err, code = os.rename(plugin_path, plugin_path)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  --	print(ok, err, code)
  if ok then
    vim.cmd("packadd " .. plugin)
  end
  return ok, err, code
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

local lisps = { "clojure", "scheme", "racket", "lisp", "fennel" }

require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- LSP
  use({ "neovim/nvim-lspconfig", opt = true })
  use({ "glepnir/lspsaga.nvim", opt = true })
  use {
    "ray-x/lsp_signature.nvim",
    opt = true,
  }

  -- Telescope
  use({ "nvim-lua/popup.nvim", opt = true })
  use({ "nvim-lua/plenary.nvim", opt = true })
  use({ "nvim-telescope/telescope.nvim", opt = true })
  use({ "nvim-telescope/telescope-fzy-native.nvim", opt = true })

  -- Debugging
  use({ "mfussenegger/nvim-dap", opt = true })

  -- Autocomplete
  use({ "hrsh7th/nvim-compe", opt = true })
  use({ "hrsh7th/vim-vsnip", opt = true })
  use({ "rafamadriz/friendly-snippets", opt = true })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "windwp/nvim-ts-autotag", opt = true })

  use({
    "folke/todo-comments.nvim",
    opt = true,
    requires = "nvim-lua/plenary.nvim",
  })

  -- Git
  use({ "TimUntersberger/neogit", opt = true })
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup()
    end,
  })
  use({
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup({
        opts = {
          remote = nil, -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").open_in_browser,
          -- print the url after performing the action
          print_url = false,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
          ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
        },
      })
    end,
  })

  -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
  use("Yggdroot/indentLine")
  use({ "windwp/nvim-autopairs", opt = true })
  use({
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  })
  use({ "kevinhwang91/nvim-bqf", opt = true })

  -- Color
  use({
    "embark-theme/vim",
    as = "embark",
  })

  -- Icons
  use({ "kyazdani42/nvim-web-devicons", opt = true })

  -- Status Line and Bufferline
  use({ "glepnir/galaxyline.nvim", opt = true })

  -- LSP plugins
  use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim", opt = true })
  use({ "scalameta/nvim-metals", opt = true })
  use({ "tjdevries/nlua.nvim", opt = true })
  use({ "folke/lsp-colors.nvim", opt = true })
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    opt = true,
  })

  -- Local
  use({ "lucaslollobrigida/project.nvim", branch = "main" })

  -- Editing
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-repeat" })
  use({ "junegunn/vim-easy-align" })
  use({
    "guns/vim-sexp",
    ft = lisps,
    requires = { "tpope/vim-sexp-mappings-for-regular-people" },
  })

  -- File browser
  use("tamago324/lir.nvim")

  -- RFC database
  use({ "mhinz/vim-rfc", opt = true })

  -- Project
  use({ "tpope/vim-projectionist", opt = true })
  use({ "tpope/vim-dispatch", opt = true })

  -- Lisp
  use({
    "Olical/conjure",
    ft = lisps,
    opt = true,
    requires = { "Olical/AnsiEsc", "tami5/compe-conjure" },
  })
  use({
    "tami5/lispdocs.nvim",
    ft = lisps,
    opt = true,
    requires = { "tami5/sql.nvim" },
  })

  require_plugin("Olical/conjure")
  require_plugin("tamago324/lir.nvim")
  require_plugin("tami5/compe-conjure")
  require_plugin("tami5/lispdocs.nvim")
  require_plugin("tami5/sql.nvim")
  require_plugin("nvim-lspconfig")
  require_plugin("lsp_signature.nvim")
  require_plugin("lspsaga.nvim")
  require_plugin("friendly-snippets")
  require_plugin("popup.nvim")
  require_plugin("plenary.nvim")
  require_plugin("telescope.nvim")
  require_plugin("telescope-fzy-native.nvim")
  require_plugin("nvim-dap")
  require_plugin("neogit")
  require_plugin("nvim-compe")
  require_plugin("vim-vsnip")
  require_plugin("nvim-treesitter")
  require_plugin("nvim-ts-autotag")
  require_plugin("nvim-metals")
  require_plugin("nlua.nvim")
  require_plugin("flutter-tools.nvim")
  require_plugin("nvim-autopairs")
  require_plugin("nvim-comment")
  require_plugin("nvim-bqf")
  require_plugin("nvim-web-devicons")
  require_plugin("galaxyline.nvim")
  require_plugin("lsp-colors.nvim")
  require_plugin("vim-projectionist")
  require_plugin("vim-dispatch")
  require_plugin("vim-rfc")
  require_plugin("trouble.nvim")
  require_plugin("todo-comments.nvim")
end)

require("plugins.telescope")
require("plugins.compe")
require("plugins.galaxyline")
require("plugins.lisp")
require("plugins.autopairs")
require("plugins.lir")
require("plugins.projections")
