{ config, lib, pkgs, ... }:

{
  imports = [
    ./clitools.nix
    ./clojure.nix
    ./elixir.nix
    ./go.nix
    # ./haskell.nix
    ./nix.nix
    ./nubank.nix
    ./scala.nix
    ./scripting.nix
  ];
}
