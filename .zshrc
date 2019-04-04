export PATH=$HOME/bin:/usr/local/bin:/usr/local/go/bin:$HOME/go/bin:$PATH

export ZSH=$HOME/.oh-my-zsh
export EDITOR=nvim
export GOPATH=$HOME/go

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
  zsh-autosuggestions
)

# Aliases
new() { 
  mkdir -p $1 
  cd $1 
  git init
}

abnt() {
  setxkbmap -model abnt2 -layout br -variant abnt2
}

alias load='source ~/.zshrc'
alias vim='nvim'
alias python='python3'
alias pip='pip3'
alias vimrc='vim ~/.config/nvim/init.vim'
alias zshrc='vim ~/.zshrc'

alias cgo="cd $GOPATH"
alias cjs='cd ~/dev/node'
alias cpy='cd ~/dev/py'
alias crb='cd ~/dev/rb'
alias ccp='cd ~/dev/cpp'
alias cvm='cd ~/.config/nvim'

source $ZSH/oh-my-zsh.sh
export GO111MODULE=on
