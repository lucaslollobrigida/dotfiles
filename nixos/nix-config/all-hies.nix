let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in {
  environment.systemPackages = [
    (all-hies.unstableFallback.selection { selector = p: { inherit (p) ghc864 ghc865; }; })
    (all-hies.unstable.selection { selector = p: { inherit (p) ghc844 ghc865; }; })
  ];
}
