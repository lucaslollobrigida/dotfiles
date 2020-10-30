tic ~/.terminfo/tmux-256color.terminfo

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"

export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME="/usr/local/opt/openjdk"
export ANDROID_HOME="$HOME/.local/share/android"
export FLUTTER_HOME="$HOME/.local/share/flutter"

export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$FLUTTER_HOME/bin"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

[ -f $HOME/.zshrc ] && source ~/.zshrc
[ -f $HOME/.nurc ] && source ~/.nurc
