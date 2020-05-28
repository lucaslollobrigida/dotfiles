{ config, pkgs, ... }:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  environment.systemPackages = with pkgs; [
    (all-hies.unstable.selection { selector = p: { inherit (p) ghc865 ghc864 ghc844 ghc843 ; }; })
    binutils
    cmake
    clojure
    clojure-lsp
    docker
    docker-compose
    gcc
    ghc
    gitFull
    gnumake
    gomodifytags
    gotests
    go
    go-tools
    haskellPackages.brittany
    impl
    joker
    kubectl
    leiningen
    libtool
    minikube
    nodejs
    pipenv
    python37Full
    python37Packages.black
    python37Packages.flake8
    python37Packages.isort
    python37Packages.jedi
    python37Packages.mypy
    python37Packages.pip
    python37Packages.pyls-black
    python37Packages.pyls-isort
    python37Packages.pyls-mypy
    python37Packages.python-language-server
    python37Packages.setuptools
    rustup
    shellcheck
    stack
    universal-ctags
    yarn
  ];

  programs.java = {
    enable = true;
    package = pkgs.openjdk11;
  };

  # Enable Java anti-aliasing.
  environment.variables._JAVA_OPTIONS = "-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on";

  virtualisation = {
    # Enable Docker.
    docker.enable = true;

    # Enable VirtualBox.
    virtualbox.host.enable = true;
  };

}
