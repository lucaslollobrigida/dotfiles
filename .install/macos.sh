#!/usr/bin/env bash

set -eo pipefail

_ssh() {
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
        ssh-keygen -t rsa
        cat ~/.ssh/id_rsa.pub | pbcopy

        echo "Public key was copied to your clipboard, press ENTER to open github and add your new key there."
        read -s -n 1 key

        open https://github.com/settings/ssh/new

        echo "Press ENTER to continue."
        read -s -n 1 key

        ssh-agent && ssh-add ~/.ssh/id_rsa
    fi
}

_dotfiles() {
    [ ! -d ~/.dotfiles ] && \
        git clone git@github.com:lucaslollobrigida/dotfiles.git ~/.dotfiles

    cd ~/.dotfiles
    stow -R macos
    stow -R dev
    stow -R vim
}

_compile_term_entries() {
    if [ ! -f ~/tmux-256color.info ]; then
        /usr/local/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.info
        tic -xe tmux-256color ~/tmux-256color.info
    fi
}

_setup_brew() {
    [ ! command -v brew &> /dev/null ] && \
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
        # TODO: break this into a `terminal` setup
        brew install coreutils firefox curl gpg git stow fzf rg exa fd gawk bat git-delta jq ncurses
        $(brew --prefix)/opt/fzf/install
}

_setup_zinit() {
    [ ! -d ~/.zinit/ ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
}

_setup_tmux() {
    brew install tmux
    [ ! -d ~/.tmux/plugins/tpm/ ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

_setup_packer() {
    local packer_path=~/.local/share/nvim/site/pack/packer/opt/packer.nvim

    [ ! -d "$packer_path" ] && \
        git clone https://github.com/wbthomason/packer.nvim "$packer_path"
}

_setup_fonts() {
    local font_path="~/.local/share/fonts/Iosevka Nerd Font Complete.ttf"

    mkdir ~/.local/share/fonts

    curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Nerd%20Font%20Complete.ttf \
        -o "$font_path"

    open "$font_path"
}

_setup_asdf() {
    brew install asdf autoconf

    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

    asdf plugin-add java https://github.com/halcyon/asdf-java.git
    asdf plugin-add clojure https://github.com/halcyon/asdf-clojure.git

    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
}

_setup_node() {
    local node_version="14.15.4"

    bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

    asdf install nodejs "$node_version"
    asdf global nodejs "$node_version"
}

_setup_jvm() {
    local java_version="adoptopenjdk-14.0.2+12"
    local clojure_version="1.10.1.739"

    asdf install java "$java_version"
    asdf global java "$java_version"

    asdf install clojure "$clojure_version"
    asdf global clojure "$clojure_version"
}

_setup_bean() {
    local erl_version="23.2.3"
    local elixir_version="1.11.3"

    asdf install erlang "$erl_version"
    asdf global erlang "$erl_version"

    asdf install elixir "$elixir_version"
    asdf global elixir "$elixir_version"
}

# using nightly build for know, until 0.5 becomes stable
_setup_neovim() {
    if [ ! command -v nvim &> /dev/null ]; then
        brew install cmake pkg-config sqlite python

        [ ! -d ~/dev/personal/neovim ] && \
            mkdir -p ~/dev/personal && \
            git clone git@github.com:neovim/neovim.git ~/dev/personal/neovim

        cd ~/dev/personal/neovim

        make CMAKE_BUILD_TYPE=RelWithDebInfo
        sudo make install


        python3 -m pip install --user --upgrade neovim-remote 
        python3 -m pip install --user --upgrade pynvim
        npm install neovim -g

        _setup_packer
        nvim +PackerSync
    fi
}

main() {
    _ssh
    _setup_brew
    _setup_zinit
    _setup_tmux
    _setup_fonts
    _setup_asdf
    _setup_node
    _dotfiles
    _compile_term_entries
    _setup_jvm
    _setup_bean
    _setup_neovim
}

main "$@"
