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
    use {'npxbr/glow.nvim'}
    use {'junegunn/goyo.vim',
      requires = {'junegunn/limelight.vim'}
    }

    use {'tpope/vim-commentary', opt = false}
    use {'tpope/vim-surround', opt = false}
    use {'tpope/vim-repeat', opt = false}
    -- use {'justinmk/vim-sneak', opt = false} -- can't live without switching ; -> : :/
    use {'jiangmiao/auto-pairs', opt = false}

    -- Project
    use {'tpope/vim-fugitive', requires = {'tpope/vim-rhubarb'}}
    use {'TimUntersberger/neogit', opt = false}
    use {'tpope/vim-vinegar', opt = false}
    use 'voldikss/vim-floaterm'
    use 'tpope/vim-projectionist'
    use {'stsewd/fzf-checkout.vim', requires = require_fzf}
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
    -- use {'eraserhd/parinfer-rust',
    --   ft = lisps,
    --   run = 'cargo build --release'}

    use {'clojure-vim/vim-jack-in', ft = {'clojure'}}

    -- Snippets
    -- use {'SirVer/ultisnips', 'natebosch/dartlang-snippets'}
    use {'norcalli/snippets.nvim', opt = false}

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
    use {'datwaft/bubbly.nvim',
    opt = false,
    config = function()
      -- Here you can add the configuration for the plugin
      vim.g.bubbly_palette = {
         background = "#34343c",
         foreground = "#c5cdd9",
         black = "#3e4249",
         red = "#ec7279",
         green = "#a0c980",
         yellow = "#deb974",
         blue = "#6cb6eb",
         purple = "#d38aea",
         cyan = "#5dbbc1",
         white = "#c5cdd9",
         lightgrey = "#57595e",
         darkgrey = "#404247",
      }
      vim.g.bubbly_statusline = {
        'mode',

         'truncate',

         'path',
         'branch',
         'signify',
         'builtinlsp.diagnostic_count',

         'divisor',

         'builtinlsp.current_function',
         'filetype',
         'progress',
      }
   end}
    use 'mhinz/vim-signify'
    use 'Shougo/echodoc.vim'
    -- use 'ncm2/float-preview.nvim'
    use 'ryanoasis/vim-devicons'
    -- colorscheme (TODO: create a conditional based on globals.colorscheme)
    use {'glepnir/zephyr-nvim'}
    use {'bluz71/vim-nightfly-guicolors'}
    use {'ayu-theme/ayu-vim'}

    use 'elixir-editors/vim-elixir'
    use 'dart-lang/dart-vim-plugin'
  end,
  config = { opt_default = true }})
