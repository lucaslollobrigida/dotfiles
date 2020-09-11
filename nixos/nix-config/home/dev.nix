{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # general
    awscli
    heroku
    ninja
    silver-searcher
    bat
    gitAndTools.delta
    openssl

    # clojure
    clojure
    clojure-lsp
    joker
    leiningen

    # elixir
    elixir

    # c
    clang-tools
    cmake
    gcc
    glibc
    gnumake
    universal-ctags

    # flutter
    dart_dev
    flutter

    # haskell
    ghc
    haskellPackages.ghcide
    haskellPackages.brittany
    haskellPackages.hoogle
    stack

    # golang
    go
    goimports
    gomodifytags
    gopls
    gotests
    go-tools
    impl

    # docker/kubernetes
    docker-compose
    kubectl
    minikube

    # lua
    libtool
    luajit

    # java
    gradle
    maven

    # js
    nodejs
    yarn
    nodePackages.typescript-language-server

    # python
    pipenv
    python37Full
    python37Packages.black
    python37Packages.flake8
    python37Packages.isort
    python37Packages.jedi
    python37Packages.mypy
    python37Packages.pip
    # python37Packages.pyls-black
    python37Packages.pyls-isort
    python37Packages.pyls-mypy
    python37Packages.python-language-server
    python37Packages.setuptools

    # nix
    rnix-lsp

    # rust
    rust-analyzer
    rustup

    # shell
    shellcheck
  ];
}
