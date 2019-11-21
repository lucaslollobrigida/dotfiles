# .bashrc

# User specific environment
if ! [[ "$PATH" =~ ":$HOME/.local/bin:$HOME/bin" ]]; then
    PATH+=":$HOME/.local/bin:$HOME/bin"
fi

if ! [[ "$PATH" =~ ":$HOME/Library/Python/3.7/bin" ]]; then
    PATH+=":$HOME/Library/Python/3.7/bin"
fi

if ! [[ "$PATH" =~ ":$HOME/go/bin" ]]; then
    PATH+=":$HOME/go/bin"
fi

if ! [[ "$PATH" =~ ":$HOME/.asdf/installs/clojure/1.10.1/bin" ]]; then
    PATH+=":$HOME/.asdf/installs/clojure/1.10.1/bin"
fi

if ! [[ "$PATH" =~ ":$HOME/.asdf/installs/yarn/1.19.0/bin" ]]; then
    PATH+=":$HOME/.asdf/installs/yarn/1.19.0/bin"
fi

if ! [[ "$PATH" =~ ":$HOME/.asdf/installs/nodejs/12.11.1/bin" ]]; then
    PATH+=":$HOME/.asdf/installs/nodejs/12.11.1/bin"
fi

export PATH

# export EDITOR="nvim -U NONE"
export TERM=xterm-color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export CLICOLOR=YES
export GPG_TTY=$(tty)

export XDG_CACHE_HOME="$HOME/.cache"

# History Configuration
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

shopt -s histappend
shopt -s cmdhist

PROMPT_COMMAND='history -a'
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTTIMEFORMAT='%F %T '

. $(brew --prefix asdf)/asdf.sh

[ -f ~/.bash_prompt ] && source ~/.bash_prompt
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/local/etc/profile.d/bash_completion.sh ] && source /usr/local/etc/profile.d/bash_completion.sh
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
[ -f ~/.asdf/completions/asdf.bash ] && source ~/.asdf/completions/asdf.bash
[ -f ~/.asdf/plugins/java/set-java-home.sh ] && source ~/.asdf/plugins/java/set-java-home.sh

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi
