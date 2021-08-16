{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hydra-check
    nix-update
    nixfmt
    nixpkgs-fmt
    nixpkgs-review
    rnix-lsp
  ];
}
