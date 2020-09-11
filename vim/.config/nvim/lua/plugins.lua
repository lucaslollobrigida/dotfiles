local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. 'packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  return
end

local packer = require('packer')
local use = packer.use

return packer.startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Simple plugins can be specified as strings
  use 'sainnhe/sonokai'
  use 'mhinz/vim-signify'
  use 'ryanoasis/vim-devicons'
  use 'ncm2/float-preview.nvim'
  use 'norcalli/nvim-terminal.lua'

  -- Statusline - Local version for now ...
  use '~/dev/lua/express_line.nvim/'

  -- Focus Mode
  use {'junegunn/goyo.vim',
       opt = true,
       requires = {{'junegunn/limelight.vim'}}
  }

  -- Async jobs
  use 'tjdevries/luvjob.nvim'

  -- Editing
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'jiangmiao/auto-pairs'

  -- Project
  use 'tpope/vim-fugitive'
  use 'voldikss/vim-floaterm'
  use 'justinmk/vim-dirvish'
  use 'tpope/vim-projectionist'
  use 'm00qek/nvim-contabs'
  use {'tpope/vim-dispatch',
       opt = true,
       cmd = {'Dispatch', 'Make', 'Focus', 'Start', 'AbortDispatch'},
       requires = {{'radenling/vim-dispatch-neovim', opt = true}}
  }

  use {'junegunn/fzf.vim',
       requires = {{'junegunn/fzf'}}
  }

  -- Lisp editing
  use 'luochen1990/rainbow'
  use {'guns/vim-sexp',
       requires = {'tpope/vim-sexp-mappings-for-regular-people'}
  }

  -- REPL integration
  use {'clojure-vim/vim-jack-in',
       ft = {'clojure'}
  }
  use {'Olical/conjure',
       ft = {'clojure'},
       requires = {{'Olical/AnsiEsc', opt = true}}
  }

  -- Static analyses and completion
  use {'neovim/nvim-lsp',
       'nvim-lua/diagnostic-nvim',
       'nvim-lua/lsp-status.nvim',
       {'nvim-lua/completion-nvim',
        requires = {'hrsh7th/vim-vsnip',
                    'hrsh7th/vim-vsnip-integ',
                    {'m00qek/completion-conjure', ft = {'clojure'}}
            }
       }
  }

  -- Syntax
  use {'guns/vim-clojure-static',
       ft = {'clojure'}
  }
  use {'dart-lang/dart-vim-plugin',
       ft = {'dart'}
  }
  use {'leafgarland/typescript-vim',
       'peitalin/vim-jsx-typescript',
       ft = {'typescript', 'typescript.jsx'}
  }

  use 'LnL7/vim-nix'
  use 'euclidianAce/BetterLua.vim'
  use 'plasticboy/vim-markdown'

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  -- use {
  --   'w0rp/ale',
  --   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- }

-- " Produtivity
-- Plug 'ihsanturk/neuron.vim'
-- " Plug 'vimwiki/vimwiki'
end)
