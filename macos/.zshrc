#!/usr/bin/env zsh

###########
### Env ###
###########

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

export ANDROID_HOME="$HOME/.local/share/android"
export FLUTTER_HOME="$HOME/.local/share/flutter"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.fzf/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.asdf/shims"
export PATH="$PATH:$FLUTTER_HOME/bin"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

###############
### Config ###
###############

unsetopt correct_all
setopt noflowcontrol
setopt hist_ignore_all_dups
setopt hist_ignore_space

export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.config/history"

# User configuration
# bindkey -v
export KEYTIMEOUT=1

export FPATH=/usr/share/zsh/5.3/functions:$FPATH
export MANPATH="/usr/local/man:$MANPATH"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export TERMINFO=~/.terminfo

export EDITOR=nvim

export GO111MODULE=on

# Compilation flags
export ARCHFLAGS="-arch x86_64"

export FZF_DEFAULT_OPTS='
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'
export COLORTERM="truecolor"

###############
### Aliases ###
###############

alias vim="nvim"
alias rr="ranger"

alias vc="nvim -U NONE $HOME/.config/nvim/init.vim"
alias zc="nvim -U NONE $HOME/.zshrc"

alias src="cd $HOME/src/"
alias dot="cd $HOME/.dotfiles/"

alias ip='ipconfig getifaddr en0'

alias ls="exa --color=always --group-directories-first"
alias ll="exa -l --color=always --group-directories-first"
alias la="exa -al --color=always --group-directories-first"
alias lt="exa -aT --color=always --group-directories-first --git-ignore -I .git"

alias so="source $HOME/.zshrc"

################
### External ###
################

[ -f ~/.functions.sh ] && source ~/.functions.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh
[ -f ~/.asdf/plugins/java/set-java-home.zsh ] && source ~/.asdf/plugins/java/set-java-home.zsh
[ -f $HOME/.nurc ] && source ~/.nurc

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# HEROKU_AC_ZSH_SETUP_PATH=/Users/lucas.lollobrigida/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

###############
### Plugins ###
###############

zinit light zsh-users/zsh-autosuggestions
# zinit light zdharma/fast-syntax-highlighting

zinit ice from"gh-r" as"command"
zinit load junegunn/fzf-bin

zinit ice compile "(pure|async).zsh" pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zstyle :prompt:pure:path color white
zstyle ':prompt:pure:prompt:*' color cyan
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:branch color green

export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"
