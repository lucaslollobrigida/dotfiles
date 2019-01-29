#!/bin/sh

if [ $# -lt 2 ]; then
  printf "${RED}" "Supply both name and email to continue..."
  exit 1
fi

if [ -z "$3" ] || [ "$3" = "--bash" ]; then
  PATH_RC="~/.bashrc"
elif [ "$3" = "--zsh" ]; then
  PATH_RC="~/.zshrc"
else
  printf "${RED}" "Invalid shell..."
  exit 1
fi

RED='\e[1;31m%s\e[0m\n'
GREEN='\e[0;32m%s\e[0m\n'
YELLOW='\e[1;33m%s\e[0m\n'

init() {
  printf "${GREEN}" "Initializing installation"
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt install git -y
  sudo git config --global user.email "$2"
  sudo git config --global user.name "$1"
}

utility() {
  printf "${GREEN}" "Installing utility packages"
  sudo apt-get install curl \
    apt-transport-https \
    build-essential \
    ca-certificates \
    git-core \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libffi-dev \
    libsqlite3-dev \
    sqlite3 \
    software-properties-common \
    silversearcher-ag \ 
    tree \
    zlib1g-dev
}

nvmSetup() {
  printf "${GREEN}" "Installing nvm"
  mkdir "$HOME/.nvm"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sh
  nvm install --lts
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - -y
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get install yarn -y
}

pythonSetup() {
  printf "${GREEN}" "Installing python"
  sudo apt-get install python-dev python-pip python3-dev python3-pip -y
}

vimSetup() {
  printf "${GREEN}" "Installing neovim"
  sudo add-apt-repository ppa:neovim-ppa/stable -y
  sudo apt-get update -y
  sudo apt-get install neovim -y

  sudo pip2 install --upgrade pynvim
  sudo pip3 install --upgrade pynvim

  sudo npm install -g neovim

  mkdir ~/.config
  git clone https://github.com/lucaslollobrigida/nvim.git ~/.config/

  sudo git config --global core.editor "nvim"
}

pgSetup() {
  printf "${GREEN}" "Installing postgres"
  curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/.s.list.d/pgdg.list'
  sudo apt-get update -y
  sudo apt-get install postgresql-11 -y
}

dockerSetup() {
  printf "${GREEN}" "Installing docker"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install docker-ce -y

  sudo groupadd docker
  sudo usermod -aG docker $USER

  sudo systemctl enable docker
  sudo systemctl start docker
}

dockerComposeSetup() {
  printf "${GREEN}" "Installing docker-compose"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

zshSetup() {
  if [ $PATH_RC = "~/.zshrc" ]; then
    printf "${GREEN}" "Installing zsh"
    sudo apt-get install zsh -y
    sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp .zshrc ~/
    cp .fzf.zsh ~/
    chsh -s $(which zsh)
  fi
}

goSetup() {
  printf "${GREEN}" "Installing golang"
  sudo apt install golang -y
  echo 'export GOPATH=$HOME/go' >> $PATH_RC 
  echo 'export PATH=${PATH}:${GOPATH}/bin' >> $PATH_RC 
  mkdir -p $HOME/go/bin
  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
}

rubySetup() {
  # printf "${GREEN}" "Installing ruby"
  # PATH_RBENV=~/.rbenv
  # if [ ! -d "$PATH_RBENV" ]; then
  #   git clone https://github.com/rbenv/rbenv.git $PATH_RBENV
  # fi
  # echo 'export PATH=${PATH}:${HOME}/.rbenv/bin' >> $PATH_RC
  # echo 'eval "$(rbenv init -)"' >> "${PATH_RC}"
  # exec $SHELL
  #
  # git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  # echo 'export PATH=${PATH}:${HOME}/.rbenv/plugins/ruby-build/bin' >> $PATH_RC
  # exec $SHELL
  # gem install bundler
  # rbenv rehash
}

railsSetup() {
  # printf "${GREEN}" "Installing rails"
  # gem install rails -v 5.2.1
  # rbenv rehash
}

init "$1" "$2"
utility
zshSetup
nvmSetup
pythonSetup
goSetup
rubySetup
railsSetup
vimSetup
dockerSetup 
dockerComposeSetup
pgSetup
printf "${YELLOW}" "Some changes require logout to take place"

