export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"

export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME="/usr/local/opt/openjdk"

export PATH="$HOME/.emacs.d/bin/:$PATH"
export PATH="$HOME/.local/bin/:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"

# export FLUTTER_HOME="$HOME/src/flutter"

[ -f $HOME/.zshrc ] && source ~/.zshrc
[ -f $HOME/.nurc ] && source ~/.nurc
