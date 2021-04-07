local function check_installation()
  local packer_exists = pcall(Packadd, 'packer.nvim')

  if not packer_exists then
    if vim.fn.input("Download Packer? (y/n)") ~= "y" then
      return
    end

    local directory = string.format(
      '%s/site/pack/packer/opt',
      vim.fn.stdpath('data')
    )

    vim.fn.mkdir(directory, 'p')

    local out = vim.fn.system(string.format(
      'git clone %s %s',
      'https://github.com/wbthomason/packer.nvim',
      directory .. '/packer.nvim'
    ))

    print(out)
    print("Downloading packer.nvim...")
    Packadd('packer.nvim')
  end
end

check_installation()

local globals = require('lollo.config')
local packer = require('packer')
local use = packer.use

packer.startup({
  function()
    local lisps = {'clojure', 'scheme', 'racket', 'lisp', 'fennel'}
    local non_lisps = {'elixir', 'scala', 'dart', 'go',  'rust', 'c', 'vim', 'lua', 'java'}
    local require_fzf = {'junegunn/fzf.vim', 'junegunn/fzf'}

    use 'wbthomason/packer.nvim'

    if globals.finder == 'fzf' then
      use {
        'junegunn/fzf.vim',
        requires = {'junegunn/fzf'}
      }
    elseif globals.finder == 'telescope' then
      use {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/popup.nvim',
          'nvim-lua/plenary.nvim',
          'nvim-telescope/telescope-fzy-native.nvim',
          'nvim-telescope/telescope-fzf-writer.nvim',
          -- 'nvim-telescope/telescope-project.nvim',
          {'nvim-telescope/telescope-frecency.nvim', requires = {'tami5/sql.nvim', opt = false}},
        }
      }
    end

    -- Focus Mode
    use {'junegunn/goyo.vim',
      requires = {'junegunn/limelight.vim'}
    }

    use {'tpope/vim-commentary', opt = false}
    use {'tpope/vim-surround', opt = false}
    use {'tpope/vim-repeat', opt = false}
    use {'jiangmiao/auto-pairs', opt = false}

    -- Project
    use {'tpope/vim-fugitive', requires = {'tpope/vim-rhubarb'}}
    use {'TimUntersberger/neogit', opt = false}
    use {'tpope/vim-vinegar', opt = false}
    use 'tpope/vim-projectionist'
    use {'m00qek/nvim-contabs', requires = require_fzf}

    use {'tpope/vim-dispatch',
      cmd = {'Dispatch', 'Make', 'Focus', 'Start', 'AbortDispatch'},
      requires = {'radenling/vim-dispatch-neovim'}
    }

    -- Lisp
    use {'guns/vim-sexp',
      ft = lisps,
      requires = {'tpope/vim-sexp-mappings-for-regular-people'}
    }
    use {'Olical/conjure',
      ft = lisps,
      requires = {'Olical/AnsiEsc', 'tami5/compe-conjure'}
    }
    use {'tami5/lispdocs.nvim',
      ft = lisps,
      requires = {'tami5/sql.nvim'}
    }

    use {'clojure-vim/vim-jack-in', ft = {'clojure'}}

    -- Snippets
    use {'hrsh7th/vim-vsnip', opt = false, requires = {'hrsh7th/vim-vsnip-integ', opt = false}}

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- Lsp
    if globals.builtin_lsp then
      use {
        'neovim/nvim-lspconfig',
        requires = {
          'hrsh7th/nvim-compe', 'nvim-lua/lsp-status.nvim', 'nvim-lua/lsp_extensions.nvim', 'RishabhRD/popfix', 'RishabhRD/nvim-lsputils'
        }
      }
      use 'akinsho/flutter-tools.nvim'
      use 'crispgm/nvim-go'
      use 'tjdevries/nlua.nvim'
    else
      -- use 'neoclide/coc.nvim'
    end

    -- use 'vim-test/vim-test'
    -- use 'reinh/vim-makegreen'

    -- Visual
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      opt = false,
      config = function()
        require('lualine').setup{
          options = {
            theme = 'nightfly',
            icons_enabled = true,
            section_separators = '',
            component_separators = '',
          },
          sections = {
            lualine_a = { {'mode', upper = true} },
            lualine_b = { 'b:gitsigns_status', {'b:gitsigns_head', icon = ''} },
            lualine_c = { {'diagnostics', sources = {'nvim_lsp'}}, {'filename', file_status = true, full_path = true} },
            lualine_x = { 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location'  },
          },
          inactive_sections = {
            lualine_a = { {'mode', upper = true} },
            lualine_b = {  },
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {  },
            lualine_z = {   }
          },
          extensions = { 'fugitive' }
        }
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      opt = false,
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup()
      end
    }
    use 'ryanoasis/vim-devicons'
    -- colorscheme (TODO: create a conditional based on globals.colorscheme)
    use {'glepnir/zephyr-nvim'}
    use {'bluz71/vim-nightfly-guicolors'}
    use {'ayu-theme/ayu-vim'}
    use {'embark-theme/vim',
    opt = false,
    as = 'embark',
  }

    use {'wlangstroth/vim-racket', opt = false}
    use {'ds26gte/neoscmindent', opt = false}
    use {'elixir-editors/vim-elixir', opt = false}
    use {'dart-lang/dart-vim-plugin', opt = false}
  end,
  config = { opt_default = true }})
