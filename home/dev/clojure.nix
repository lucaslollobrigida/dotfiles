{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    babashka
    clojure
    clj-kondo
    clojure-lsp
    leiningen
  ];

  programs.zsh.shellAliases = { bb = "rlwrap bb"; };

  # TODO: create ~/.lein and ~/.config/clojure files
}
