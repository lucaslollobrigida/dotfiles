# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

PATH="$HOME/go/bin:$PATH"
export PATH

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export XDG_CACHE_HOME="$HOME/.cache"
export GPG_TTY=$(tty)

# History Configuration
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND='history -a'
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Aliases
alias vim='nvim'
alias bc='vim -u NONE $HOME/.bashrc'
alias vc='vim -u NONE $HOME/.config/nvim/init.vim'
alias load='source $HOME/.bashrc'

alias la='ls -lA'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gps='git push'
alias gpl='git pull'
alias gr='git remote'
alias gra='git remote add'
alias gl='git log'
alias gd='git diff'
alias gck='git checkout'

# Functions
new() {
    mkdir $1; cd $1; git init
}

pg_run() {
    if hash docker 2>/dev/null; then
	docker run --name pg-container -e POSTGRES_PASSWORD=root -d postgres
    else
	echo 'Docker is not installed or missing from PATH.'
    fi
}

redis_run() {
    if hash docker 2>/dev/null; then
	docker run --name redis-container -d redis
    else
	echo 'Docker is not installed or missing from PATH.'
    fi
}

[ -f ~/.bash_prompt ] && source ~/.bash_prompt

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
[ -f ~/.asdf/completions/asdf.bash ] && source ~/.asdf/completions/asdf.bash
[ -f ~/.asdf/plugins/java/set-java-home.sh ] && source ~/.asdf/plugins/java/set-java-home.sh
