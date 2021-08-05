{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # adoptopenjdk-jre-openj9-bin-8
    babashka
    clojure
    clj-kondo
    clojure-lsp
    leiningen
  ];

  programs.zsh.shellAliases = {
    bb = "rlwrap bb";
  };

  # TODO: create ~/.lein and ~/.config/clojure files
}
