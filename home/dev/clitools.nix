{ pkgs, ... }:
let
  say = pkgs.writeScriptBin "say" ''
    #!usr/bin/env sh

    espeak -v us-mbrola-1 "$@"
  '';
in {
  home.packages = with pkgs; [
    aws
    aws-iam-authenticator
    bat
    circleci-cli
    coreutils
    curl
    espeak
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
    say
    tektoncd-cli
    telnet
    wget
    unrar
    unzip
    zip
  ];
}
