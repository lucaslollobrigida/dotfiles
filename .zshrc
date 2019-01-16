export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

CASE_SENSITIVE="true"

ZSH_THEME="robbyrussell"

plugins=(
  common-aliases
  docker
  git
  node
  npm
  ssh-agent
  sudo
)

# Aliases
new() { 
  mkdir -p $1 
  cd $1 
  git init
}

alias home='cd ~'
alias root='cd /'
alias load='source ~/.zshrc'
alias vim='nvim'
alias vimrc='vim ~/.config/nvim/init.vim'
alias zshrc='vim ~/.zshrc'
alias python='python3'
alias pip='pip3'

alias cjs='cd ~/dev/js'
alias cpy='cd ~/dev/py'
alias cc='cd ~/dev/c-lang'
alias ccp='cd ~/dev/c++'
alias cph='cd ~/dev/php'
alias cvm='cd ~/.config/nvim'

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim

export GOPATH=/home/lucas/go
export PATH=$PATH:/home/lucas/go/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
