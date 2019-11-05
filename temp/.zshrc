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

mongo_run() {
  docker run --rm -d --hostname mongodb -p 27017:27017 mongo:latest
}

redis_run() {
  docker run --rm -d --hostname redis -p 6379:6379 redis:latest
}

rabbit_run() {
  docker run --rm -d --hostname rabbitmq -p 5672:5672 rabbitmq:latest
}

pg_run() {
  docker run --rm -d --hostname pg -p 5432:5432 postgres:latest
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

WRKDIR="$HOME/dev"

alias work="cd $WRKDIR"
alias cgo="cd $WRKDIR/go"
alias cjs="cd $WRKDIR/node"
alias cpy="cd $WRKDIR/py"
alias crb="cd $WRKDIR/rb"
alias ccl="cd $WRKDIR/c-lang"
alias ccp="cd $WRKDIR/cpp"
alias cvm="cd ~/.config/nvim"

source $ZSH/oh-my-zsh.sh