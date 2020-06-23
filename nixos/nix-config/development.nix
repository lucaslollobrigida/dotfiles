{ config, pkgs, ... }:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  # ghcide   = (import (fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {}).ghcide-ghc865;
in
{
  environment.systemPackages = with pkgs; [
    (all-hies.selection { selector = p: { inherit (p) ghc865 ; }; })
    binutils
    cmake
    clojure
    clojure-lsp
    docker
    docker-compose
    elixir
    gcc
    ghc
    glibc
    # ghcide
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
    maven
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
    rnix-lsp
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
