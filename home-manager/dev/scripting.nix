{ pkgs, ... }:

{
  # TODO: missing luastyle
  home.packages = with pkgs; [
    nodejs
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    python38Full
    jupyter
    python38Packages.jupyter_core
    shellcheck
    sumneko-lua-language-server
    terraform-lsp
    texlab # TODO: move
    yarn
  ];
}
