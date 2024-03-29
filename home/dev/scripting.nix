{ pkgs, ... }:

{
  home.packages = with pkgs; [
    graphviz
    nodejs-12_x
    nodePackages.bash-language-server
    nodePackages.eslint_d
    nodePackages.lerna
    nodePackages.typescript-language-server
    python38Full
    jupyter
    plantuml
    postgresql
    python38Packages.jupyter_core
    shellcheck
    sumneko-lua-language-server
    terraform-lsp
    texlab # TODO: move
    unstable.stylua
    yarn
  ];
}
