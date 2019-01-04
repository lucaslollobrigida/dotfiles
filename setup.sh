#!/bin/sh

init() {
  sudo apt-get update
  sudo apt-get upgrade
  sudo git config --global user.email "lucaslollobrigida@gmail.com"
  sudo git config --global user.name "Lucas Lollobrigida"
}

essentials() {
  sudo apt-get install curl -y
  sudo apt-get install apt-transport-https -y
  sudo apt-get install ca-certificates -y
  sudo apt-get install software-properties-common -y
  sudo apt-get install tree -y
}

nvmSetup() {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
  nvm install --lts
}

pipSetup() {
  sudo apt-get install python-dev python-pip python3-dev python3-pip -y
}

vimSetup() {
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install neovim -y

  sudo pip2 install --upgrade pynvim
  sudo pip3 install --upgrade pynvim

  sudo npm install -g neovim

  mkdir ~/.config
  git clone https://github.com/lucaslollobrigida/nvim.git ~/.config/

  sudo git config --global core.editor "nvim"
}

pgSetup() {
  curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  sudo apt-get update
  sudo apt-get install postgresql-11 pgadmin4
}

dockerSetup() {
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
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

terminalSetup() {
  sudo apt-get install zsh -y
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  mv .zshrc ~/
  chsh -s /bin/zsh user
}

goSetup() {
  sudo apt install golang
  echo 'export GOPATH=$HOME/go' >> ~/.zshrc 
  echo 'export PATH=${PATH}:${GOPATH}/bin' >> ~/.zshrc 
  source ~/.zshrc 
  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
}
init && essentials && terminalSetup && nvmSetup && pipSetup && vimSetup && dockerSetup && dockerComposeSetup && pgSetup && goSetup
