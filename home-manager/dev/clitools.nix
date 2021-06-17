{ pkgs, ... }:

{
  home.packages = with pkgs; [
    aws
    aws-iam-authenticator
    bat
    circleci-cli
    coreutils
    curl
    exa
    fd
    fzf
    gcc
    gettext
    gnumake
    htop
    jq
    kubectl
    minikube
    openfortivpn
    openssl
    ripgrep
    rlwrap
    sassc
    tektoncd-cli
    telnet
    tmux
    wget
    unrar
    unzip
    zip
  ];
}
