{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # clojure
    clojure
    clojure-lsp
    joker
    leiningen

    elixir

    # c
    clang-tools
    cmake
    gcc
    glibc
    gnumake
    universal-ctags

    # haskell
    ghc
    haskellPackages.ghcide
    haskellPackages.brittany
    haskellPackages.hoogle
    stack

    # golang
    goimports
    gomodifytags
    gotests
    go
    go-tools
    impl

    # docker/kubernetes
    docker-compose
    kubectl
    minikube

    # lua
    libtool
    luajitPackages.lua-lsp

    # java
    maven

    # node
    nodejs
    yarn

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
