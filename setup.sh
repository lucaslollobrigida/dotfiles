#!/bin/sh

if [ $# -lt 2 ]; then
  printf "${RED}" "Supply both name and email to continue..."
  exit 1
fi

if [ -z "$3" ] || [ "$3" = "--bash" ]; then
  PATH_RC=~/.bashrc
elif [ "$3" = "--zsh" ]; then
  PATH_RC=~/.zshrc
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

  # workplace folders
  mkdir -p $HOME/dev/node
  mkdir -p $HOME/dev/py
  mkdir -p $HOME/dev/rb
  mkdir -p $HOME/dev/cpp
}

utility() {
  printf "${GREEN}" "Installing utility packages"
  sudo apt-get install \
    curl \
    apt-transport-https \
    build-essential \
    ca-certificates \
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
    unzip -y

  sudo apt install \
    zlib1g-dev \
    autoconf \
    bison \
    libncurses5-dev \
    libffi-dev \
    libgdbm-dev -y
}

nvmSetup() {
  printf "${GREEN}" "Installing nvm"
  mkdir "$HOME/.nvm"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | sh
  source $PATH_RC
  nvm install 10
  nvm use 10
  npm i -g typescript neovim nodemon tern
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
  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/source.list.d/pgdg.list
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install postgresql-11
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
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

zshSetup() {
if [ "$PATH_RC" = "~/.zshrc" ]; then
    printf "${GREEN}" "Installing zsh"
    sudo apt-get install zsh -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp .zshrc ~/
    cp .fzf.zsh ~/
    chsh -s $(which zsh)
  fi
}

goSetup() {
  printf "${GREEN}" "Installing golang"
  curl https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz --output go1.11.5.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.11.5.linux-amd64.tar.gz
  rm -f go1.11.5.linux-amd64.tar.gz
  echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" | tee -a $PATH_RC
  echo "export GOPATH=$HOME/go" | tee -a $PATH_RC
  echo "export GO111MODULE=on" | tee -a $PATH_RC
  source $PATH_RC
  mkdir -p $HOME/go/bin
  mkdir -p $HOME/go/src/github.com
}

rubySetup() {
  curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash -
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' | tee -a $PATH_RC
  echo 'eval "$(rbenv init -)"' | tee -a $PATH_RC
  source $PATH_RC
  rbenv install 2.6.1
  rbenv global 2.6.1
  echo "gem: --no-document" | tee ~/.gemrc
  gem install bundler
  rbenv rehash
  gem install neovim
  rbenv rehash
}

rails() {
  gem install rails
  rbenv rehash
}

fontSetup() {
  FONT_PATH=~/.local/share/fonts 
  mkdir -p $FONT_PATH
  curl \
    -Lo $FONT_PATH/3270.zip \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/3270.zip 
  unzip $FONT_PATH/3270.zip -d $FONT_PATH
}

init "$1" "$2"
utility
zshSetup
nvmSetup
pythonSetup
goSetup
vimSetup
dockerSetup 
dockerComposeSetup
rubySetup
pgSetup
fontSetup
printf "${YELLOW}" "Some changes require logout to take place"
