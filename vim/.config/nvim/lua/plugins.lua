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

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- LSP
  use({ "neovim/nvim-lspconfig", opt = true })
  use({ "glepnir/lspsaga.nvim", opt = true })
  use({ "kabouzeid/nvim-lspinstall", opt = true })

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

  -- use {'lukas-reineke/indent-blankline.nvim', opt=true, branch = 'lua'}
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
  -- use({ "ray-x/go.nvim", opt = false })
  use({ "tjdevries/nlua.nvim", opt = true })

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
  -- use 'crispgm/nvim-go'
  -- require_plugin("go")

  require_plugin("Olical/conjure")
  require_plugin("tamago324/lir.nvim")
  require_plugin("tami5/compe-conjure")
  require_plugin("tami5/lispdocs.nvim")
  require_plugin("tami5/sql.nvim")
  require_plugin("nvim-lspconfig")
  require_plugin("lspsaga.nvim")
  require_plugin("nvim-lspinstall")
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
end)
