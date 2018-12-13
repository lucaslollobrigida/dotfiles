export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lucaslollobrigida/.oh-my-zsh"

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