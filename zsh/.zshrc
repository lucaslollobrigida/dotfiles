export FPATH=/usr/share/zsh/5.3/functions:$FPATH

ZSH_THEME="lambda"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

ZSH_TMUX_AUTOSTART="false"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	asdf
	docker
	fzf
	gitfast
	git-extras
	gpg-agent
	kubectl
	lein
	mvn
	tmux
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting
)


for file in ${HOME}/.zsh.d/*.zsh; do
  [[ -f "${file}" ]] && source "${file}"
done

[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f $HOME/.zsh.d/aliases.zsh ] && source $HOME/.zsh.d/aliases.zsh

[ -f ~/.nurc ] && source ~/.nurc

[ -f /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh
[ -f /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash ] && source /usr/local/opt/asdf/etc/bash_completion.d/asdf.bash

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
