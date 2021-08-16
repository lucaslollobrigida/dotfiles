{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghc
    haskellPackages.cabal-install
    haskellPackages.ghcide
    haskellPackages.hoogle
    haskell-language-server
    ormolu
    stack
  ];
}
